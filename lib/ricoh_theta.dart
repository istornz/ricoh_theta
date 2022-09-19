
import 'package:ricoh_theta/models/device_info.dart';

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

  /// Returns the current model information like model, firmware & serial number.
  Future<DeviceInfo?> getDeviceInfo() {
    return RicohThetaPlatform.instance.getDeviceInfo();
  }

  /// Take a picture & return a thumbnail path.
  Future<String?> takePicture() {
    return RicohThetaPlatform.instance.takePicture();
  }
}
