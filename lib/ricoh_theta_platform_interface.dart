import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:ricoh_theta/models/device_info.dart';

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

  Future init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<DeviceInfo?> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo() has not been implemented.');
  }
}
