import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ricoh_theta_platform_interface.dart';

/// An implementation of [RicohThetaPlatform] that uses method channels.
class MethodChannelRicohTheta extends RicohThetaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ricoh_theta');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
