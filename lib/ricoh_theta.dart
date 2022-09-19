
import 'ricoh_theta_platform_interface.dart';

class RicohTheta {
  Future<String?> getPlatformVersion() {
    return RicohThetaPlatform.instance.getPlatformVersion();
  }
}
