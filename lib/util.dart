import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class Util {
  static String imageToString(File? imageFile) {
    if (imageFile != null) {
      final bytes = imageFile.readAsBytesSync();
      return base64Encode(bytes);
    }
    return '';
  }

  static getAvatharImage(String? img64) {
    if (img64 != null && img64.trim().isNotEmpty) {
      return MemoryImage(base64Decode(img64));
    } else {
      return const AssetImage('assets/images/person_default.jpg');
    }
  }
}
