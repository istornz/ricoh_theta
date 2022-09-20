import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:ricoh_theta/models/device_info.dart';
import 'package:ricoh_theta/models/image_infoes.dart';
import 'package:ricoh_theta/models/storage_info.dart';

import 'ricoh_theta_method_channel.dart';

abstract class RicohThetaPlatform extends PlatformInterface {
  RicohThetaPlatform() : super(token: _token);

  static final Object _token = Object();

  static RicohThetaPlatform _instance = MethodChannelRicohTheta();

  static RicohThetaPlatform get instance => _instance;

  static set instance(RicohThetaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future disconnect() {
    throw UnimplementedError('disconnect() has not been implemented.');
  }

  Future startLiveView() {
    throw UnimplementedError('startLiveView() has not been implemented.');
  }

  Future<num?> batteryLevel() {
    throw UnimplementedError('batteryLevel() has not been implemented.');
  }

  Future setTargetIp(String? ipAddress) {
    throw UnimplementedError('setTargetIp() has not been implemented.');
  }

  Future<DeviceInfo?> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo() has not been implemented.');
  }

  Future<StorageInfo?> getStorageInfo() {
    throw UnimplementedError('getStorageInfo() has not been implemented.');
  }

  Future<List<ImageInfoes>> getImageInfoes() {
    throw UnimplementedError('getImageInfoes() has not been implemented.');
  }

  Future<String?> takePicture() {
    throw UnimplementedError('takePicture() has not been implemented.');
  }

  Stream<Uint8List>? listenCameraImages() {
    throw UnimplementedError('listenCameraImages() has not been implemented.');
  }
}
