import 'package:flutter_test/flutter_test.dart';
import 'package:ricoh_theta/models/device_info.dart';
import 'package:ricoh_theta/models/image_infoes.dart';
import 'package:ricoh_theta/models/storage_info.dart';
import 'package:ricoh_theta/ricoh_theta.dart';
import 'package:ricoh_theta/ricoh_theta_platform_interface.dart';
import 'package:ricoh_theta/ricoh_theta_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRicohThetaPlatform
    with MockPlatformInterfaceMixin
    implements RicohThetaPlatform {
  @override
  Future setTargetIp(String? ipAddress) => Future.value();

  @override
  Future<DeviceInfo?> getDeviceInfo() => Future.value(
        DeviceInfo(
          model: 'Tetha Model S',
          firmwareVersion: '10.0.0',
          serialNumber: 'ABC123',
        ),
      );

  @override
  Future<String?> takePicture() => Future.value('/tmp/image.jpg');

  @override
  Future disconnect() => Future.value();

  @override
  Future<num?> batteryLevel() => Future.value(32.3);

  @override
  Future<StorageInfo?> getStorageInfo() => Future.value(
        StorageInfo(
          freeSpaceInBytes: 123,
          freeSpaceInImages: 32,
          imageHeight: 1920,
          imageWidth: 1080,
          maxCapacity: 1000,
        ),
      );

  @override
  Future<List<ImageInfoes>> getImageInfoes() {
    // TODO: implement getImageInfoes
    throw UnimplementedError();
  }
}

void main() {
  final RicohThetaPlatform initialPlatform = RicohThetaPlatform.instance;
  RicohTheta ricohThetaPlugin = RicohTheta();
  MockRicohThetaPlatform fakePlatform = MockRicohThetaPlatform();
  RicohThetaPlatform.instance = fakePlatform;

  test('$MethodChannelRicohTheta is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRicohTheta>());
  });

  test('getPlatformVersion', () async {
    final model = await ricohThetaPlugin.getDeviceInfo();
    expect(model?.model, 'Tetha Model S');
    expect(model?.firmwareVersion, '10.0.0');
    expect(model?.serialNumber, 'ABC123');
  });

  test('disconnect', () async {
    expect(await ricohThetaPlugin.disconnect(), null);
  });

  test('setTargetIp', () async {
    expect(await ricohThetaPlugin.setTargetIp('192.168.1.2'), null);
  });

  test('takePicture', () async {
    expect(await ricohThetaPlugin.takePicture(), '/tmp/image.jpg');
  });

  test('batteryLevel', () async {
    expect(await ricohThetaPlugin.batteryLevel(), 32.3);
  });
}
