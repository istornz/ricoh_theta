import 'package:flutter_test/flutter_test.dart';
import 'package:ricoh_theta/ricoh_theta.dart';
import 'package:ricoh_theta/ricoh_theta_platform_interface.dart';
import 'package:ricoh_theta/ricoh_theta_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRicohThetaPlatform
    with MockPlatformInterfaceMixin
    implements RicohThetaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RicohThetaPlatform initialPlatform = RicohThetaPlatform.instance;

  test('$MethodChannelRicohTheta is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRicohTheta>());
  });

  test('getPlatformVersion', () async {
    RicohTheta ricohThetaPlugin = RicohTheta();
    MockRicohThetaPlatform fakePlatform = MockRicohThetaPlatform();
    RicohThetaPlatform.instance = fakePlatform;

    expect(await ricohThetaPlugin.getPlatformVersion(), '42');
  });
}