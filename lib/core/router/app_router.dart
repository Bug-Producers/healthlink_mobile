import 'package:go_router/go_router.dart';
import '../../features/auth/view/screens/auth_gate.dart';
import '../../features/auth/view/screens/login_screen.dart';
import '../../features/auth/view/screens/sign_up_screen.dart';
import '../../features/auth/view/screens/forgot_password_screen.dart';
import '../../features/home/view/screens/home_page_screen.dart';

class AppRouter {
  static const String authGate = '/';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: authGate,
    routes: [
      GoRoute(
        path: authGate,
        builder: (context, state) => const AuthGate(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomePageScreen(),
      ),
    ],
  );
}