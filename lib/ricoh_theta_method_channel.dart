import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ricoh_theta/models/device_info.dart';

import 'ricoh_theta_platform_interface.dart';

class MethodChannelRicohTheta extends RicohThetaPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('ricoh_theta');

  @override
  Future<DeviceInfo?> getDeviceInfo() async {
    final data = await methodChannel.invokeMapMethod<String, String>('getDeviceInfo');
    return data != null ? DeviceInfo.fromMap(data) : null;
  }

  @override
  Future init() async {
    return methodChannel.invokeMethod<String>('init');
  }
}
