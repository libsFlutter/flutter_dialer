import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_dialer_method_channel.dart';

abstract class FlutterDialerPlatform extends PlatformInterface {
  /// Constructs a FlutterDialerPlatform.
  FlutterDialerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDialerPlatform _instance = MethodChannelFlutterDialer();

  /// The default instance of [FlutterDialerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDialer].
  static FlutterDialerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDialerPlatform] when
  /// they register themselves.
  static set instance(FlutterDialerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
