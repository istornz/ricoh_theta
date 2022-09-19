
import 'package:ricoh_theta/models/device_info.dart';

import 'ricoh_theta_platform_interface.dart';

class RicohTheta {
  Future init() {
    return RicohThetaPlatform.instance.init();
  }

  Future<DeviceInfo?> getDeviceInfo() {
    return RicohThetaPlatform.instance.getDeviceInfo();
  }
}
