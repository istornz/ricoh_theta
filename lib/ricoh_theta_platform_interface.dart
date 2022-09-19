import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ricoh_theta_method_channel.dart';

abstract class RicohThetaPlatform extends PlatformInterface {
  /// Constructs a RicohThetaPlatform.
  RicohThetaPlatform() : super(token: _token);

  static final Object _token = Object();

  static RicohThetaPlatform _instance = MethodChannelRicohTheta();

  /// The default instance of [RicohThetaPlatform] to use.
  ///
  /// Defaults to [MethodChannelRicohTheta].
  static RicohThetaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RicohThetaPlatform] when
  /// they register themselves.
  static set instance(RicohThetaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
