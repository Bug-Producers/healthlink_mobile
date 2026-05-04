import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utils/app_logger.dart';

/**
 * Singleton client for managing the WebSocket connection.
 */
class WebSocketClient {
  static final WebSocketClient _instance = WebSocketClient._internal();
  WebSocketChannel? _channel;
  StreamController<dynamic>? _notificationController;
  Timer? _reconnectTimer;
  bool _isConnecting = false;

  factory WebSocketClient() {
    return _instance;
  }

  WebSocketClient._internal();

  /// Stream of incoming notifications.
  Stream<dynamic> get notifications {
    _notificationController ??= StreamController<dynamic>.broadcast();
    return _notificationController!.stream;
  }

  /**
   * Connects to the WebSocket server and authenticates using the Firebase token.
   */
  Future<void> connect() async {
    if (_isConnecting || _channel != null) return;
    _isConnecting = true;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _isConnecting = false;
        return; // Wait until logged in
      }

      final token = await user.getIdToken();
      if (token == null) {
        _isConnecting = false;
        return;
      }

      // Read WebSocket URL from .env, with a sensible fallback.
      final wsUrl = Uri.parse(
        dotenv.env['WS_BASE_URL'] ?? 'wss://healthlink-api.loca.lt/api/ws/notifications',
      );
      _channel = WebSocketChannel.connect(wsUrl);

      // Authenticate
      _channel!.sink.add('Bearer $token');

      // Listen for messages
      _channel!.stream.listen(
        (message) {
          try {
            final decoded = jsonDecode(message);
            _notificationController?.add(decoded);
          } catch (e) {
            AppLogger.error('Failed to decode WS message', error: e, name: 'WebSocketClient');
          }
        },
        onDone: () {
          AppLogger.info('WebSocket disconnected', 'WebSocketClient');
          _scheduleReconnect();
        },
        onError: (error) {
          AppLogger.error('WebSocket error', error: error, name: 'WebSocketClient');
          _scheduleReconnect();
        },
      );

      AppLogger.info('WebSocket connected', 'WebSocketClient');
    } catch (e) {
      AppLogger.error('Failed to connect to WebSocket', error: e, name: 'WebSocketClient');
      _scheduleReconnect();
    } finally {
      _isConnecting = false;
    }
  }

  void _scheduleReconnect() {
    _channel?.sink.close();
    _channel = null;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      connect();
    });
  }

  /**
   * Disconnects the WebSocket connection.
   */
  void disconnect() {
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _channel = null;
    _isConnecting = false;
  }
}
