import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ricoh_theta/models/device_info.dart';
import 'package:ricoh_theta/models/image_infoes.dart';
import 'package:ricoh_theta/models/storage_info.dart';

import 'ricoh_theta_platform_interface.dart';

class MethodChannelRicohTheta extends RicohThetaPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('ricoh_theta');

  @override
  Future setTargetIp(String? ipAddress) async {
    return methodChannel.invokeMethod<String>('setTargetIp', {
      'ipAddress': ipAddress ?? '192.168.1.1',
    });
  }

  @override
  Future disconnect() {
    return methodChannel.invokeMethod<String>('disconnect');
  }

  @override
  Future<num?> batteryLevel() {
    return methodChannel.invokeMethod<num>('batteryLevel');
  }

  @override
  Future<StorageInfo?> getStorageInfo() async {
    final data =
        await methodChannel.invokeMapMethod<String, num>('getStorageInfo');
    return data != null ? StorageInfo.fromMap(data) : null;
  }

  @override
  Future<List<ImageInfoes>> getImageInfoes() async {
    final data = await methodChannel
        .invokeMethod<List<Map<String, dynamic>>>('getImageInfoes');

    return data != null
        ? data.map((image) => ImageInfoes.fromMap(image)).toList()
        : [];
  }

  @override
  Future<DeviceInfo?> getDeviceInfo() async {
    final data =
        await methodChannel.invokeMapMethod<String, String>('getDeviceInfo');
    return data != null ? DeviceInfo.fromMap(data) : null;
  }

  @override
  Future<String?> takePicture() {
    return methodChannel.invokeMethod<String>('takePicture');
  }
}
