import 'package:flutter/services.dart';

class PermissionService {
  static const MethodChannel _channel =
      MethodChannel('com.cricklyzer.permissions');

  static Future<bool> requestStoragePermission() async {
    try {
      final bool result =
          await _channel.invokeMethod('requestStoragePermission');
      return result;
    } on PlatformException catch (e) {
      print("Failed to request storage permission: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> checkStoragePermission() async {
    try {
      final bool result = await _channel.invokeMethod('checkStoragePermission');
      return result;
    } on PlatformException catch (e) {
      print("Failed to check storage permission: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> requestCameraPermission() async {
    try {
      final bool result =
          await _channel.invokeMethod('requestCameraPermission');
      return result;
    } on PlatformException catch (e) {
      print("Failed to request camera permission: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> checkCameraPermission() async {
    try {
      final bool result = await _channel.invokeMethod('checkCameraPermission');
      return result;
    } on PlatformException catch (e) {
      print("Failed to check camera permission: '${e.message}'.");
      return false;
    }
  }
}
