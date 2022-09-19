import 'package:ricoh_theta/models/device_info.dart';
import 'package:ricoh_theta/ricoh_theta.dart';

class RicohThetaService {
  late final RicohTheta _ricohThetaPlugin;
  
  RicohThetaService._privateConstructor() {
    _ricohThetaPlugin = RicohTheta();
  }

  static final RicohThetaService instance = RicohThetaService._privateConstructor();

  Future setTargetIp({String? ipAddress}) {
    return _ricohThetaPlugin.setTargetIp(ipAddress);
  }

  Future<DeviceInfo?> getDeviceInfo() {
    return _ricohThetaPlugin.getDeviceInfo();
  }

  Future disconnect() {
    return _ricohThetaPlugin.disconnect();
  }
}