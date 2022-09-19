import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ricoh_theta_platform_interface.dart';

class MethodChannelRicohTheta extends RicohThetaPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('ricoh_theta');

  @override
  Future<String?> getDeviceInfo() async {
    final version = await methodChannel.invokeMethod<String>('getDeviceInfo');
    return version;
  }
}
