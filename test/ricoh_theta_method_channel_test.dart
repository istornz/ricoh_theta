import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ricoh_theta/ricoh_theta_method_channel.dart';

void main() {
  MethodChannelRicohTheta platform = MethodChannelRicohTheta();
  const MethodChannel channel = MethodChannel('ricoh_theta');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
