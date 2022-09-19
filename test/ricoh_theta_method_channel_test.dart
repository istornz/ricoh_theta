import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ricoh_theta/ricoh_theta_method_channel.dart';

void main() {
  MethodChannelRicohTheta platform = MethodChannelRicohTheta();
  const MethodChannel channel = MethodChannel('ricoh_theta');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'batteryLevel') {
        return 32.3;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('batteryLevel', () async {
    expect(await platform.batteryLevel(), 32.3);
  });
}
