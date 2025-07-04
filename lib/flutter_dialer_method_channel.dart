import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_dialer_platform_interface.dart';

/// An implementation of [FlutterDialerPlatform] that uses method channels.
class MethodChannelFlutterDialer extends FlutterDialerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_dialer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
