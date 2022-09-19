import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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

  Future<String?> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo() has not been implemented.');
  }
}
