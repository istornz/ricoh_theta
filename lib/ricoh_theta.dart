
import 'dart:typed_data';

import 'package:ricoh_theta/models/device_info.dart';
import 'package:ricoh_theta/models/image_infoes.dart';
import 'package:ricoh_theta/models/storage_info.dart';

import 'ricoh_theta_platform_interface.dart';

class RicohTheta {
  /// If no ip address is provided, the default ip "192.168.1.1" is selected.
  /// This is required to setup before any other method.
  Future setTargetIp(String? ipAddress) async {
    return RicohThetaPlatform.instance.setTargetIp(ipAddress);
  }

  /// Disconnect from the device
  Future disconnect() async {
    return RicohThetaPlatform.instance.disconnect();
  }

  Future startLiveView() {
    return RicohThetaPlatform.instance.startLiveView();
  }

  /// Get battery level from device
  Future<num> batteryLevel() async {
    final battery = await RicohThetaPlatform.instance.batteryLevel();
    return (battery ?? 0) * 100;
  }

  /// Returns the current model information like model, firmware & serial number.
  Future<DeviceInfo?> getDeviceInfo() {
    return RicohThetaPlatform.instance.getDeviceInfo();
  }

  /// Returns information about the device storage.
  Future<StorageInfo?> getStorageInfo() {
    return RicohThetaPlatform.instance.getStorageInfo();
  }

  /// Returns information about the images stored on the device.
  Future<List<ImageInfoes>> getImageInfoes() {
    return RicohThetaPlatform.instance.getImageInfoes();
  }

  /// Take a picture & return a thumbnail path.
  Future<String?> takePicture() {
    return RicohThetaPlatform.instance.takePicture();
  }

  Stream<Uint8List>? listenCameraImages() {
    return RicohThetaPlatform.instance.listenCameraImages();
  }
}
