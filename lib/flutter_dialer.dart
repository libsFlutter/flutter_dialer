
import 'package:flutter/services.dart';

class FlutterDialer {
  static const MethodChannel _channel = MethodChannel('flutter_dialer');

  /// Check if this app is the default dialer
  static Future<bool> isDefaultDialer() async {
    try {
      final result = await _channel.invokeMethod('isDefaultDialer');
      return result == true;
    } on PlatformException catch (e) {
      print('FlutterDialer: PlatformException in isDefaultDialer: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('FlutterDialer: Exception in isDefaultDialer: $e');
      return false;
    }
  }

  /// Set this app as the default dialer
  static Future<bool> setDefaultDialer() async {
    try {
      final result = await _channel.invokeMethod('setDefaultDialer');
      return result == true;
    } on PlatformException catch (e) {
      print('FlutterDialer: PlatformException in setDefaultDialer: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('FlutterDialer: Exception in setDefaultDialer: $e');
      return false;
    }
  }

  /// Check if this app can be set as default dialer
  static Future<bool> canSetDefaultDialer() async {
    try {
      final result = await _channel.invokeMethod('canSetDefaultDialer');
      return result == true;
    } on PlatformException catch (e) {
      print('FlutterDialer: PlatformException in canSetDefaultDialer: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('FlutterDialer: Exception in canSetDefaultDialer: $e');
      return false;
    }
  }
}
