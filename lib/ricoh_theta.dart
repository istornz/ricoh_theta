
import 'ricoh_theta_platform_interface.dart';

class RicohTheta {
  Future<String?> getDeviceInfo() {
    return RicohThetaPlatform.instance.getDeviceInfo();
  }
}
