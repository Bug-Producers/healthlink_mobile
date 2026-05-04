import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageHelper {
  /// Returns an appropriate ImageProvider depending on whether the source
  /// is a base64 encoded string or a network URL.
  static final Uint8List _transparentImage = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=');

  static ImageProvider getImageProvider(String source) {
    if (source.isEmpty) {
      // Fallback placeholder image provider if source is empty
      return MemoryImage(_transparentImage);
    }
    
    // Check if the source is a base64 string
    // A common base64 image string from backend might start with /9j/ or iVBORw0KGgo
    // Or it could have a data URI prefix
    if (source.startsWith('data:image')) {
      final base64String = source.split(',').last;
      try {
        return MemoryImage(base64Decode(base64String));
      } catch (e) {
        return MemoryImage(_transparentImage);
      }
    } else if (source.startsWith('/9j/') || source.startsWith('iVBORw0KGgo')) {
      try {
        return MemoryImage(base64Decode(source));
      } catch (e) {
        return MemoryImage(_transparentImage);
      }
    }

    // Otherwise, assume it's a network URL
    return NetworkImage(source);
  }
}
