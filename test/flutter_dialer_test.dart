import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dialer/flutter_dialer.dart';
import 'package:flutter_dialer/flutter_dialer_platform_interface.dart';
import 'package:flutter_dialer/flutter_dialer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDialerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDialerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterDialerPlatform initialPlatform = FlutterDialerPlatform.instance;

  test('$MethodChannelFlutterDialer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDialer>());
  });

  test('getPlatformVersion', () async {
    FlutterDialer flutterDialerPlugin = FlutterDialer();
    MockFlutterDialerPlatform fakePlatform = MockFlutterDialerPlatform();
    FlutterDialerPlatform.instance = fakePlatform;

    expect(await flutterDialerPlugin.getPlatformVersion(), '42');
  });
}
