#import "RicohThetaPlugin.h"
#import "HttpConnection.h"

@implementation RicohThetaPlugin {
  HttpConnection *_httpConnection;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"ricoh_theta"
            binaryMessenger:[registrar messenger]];
  RicohThetaPlugin* instance = [[RicohThetaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"init" isEqualToString:call.method]) {
    [self _handleInit:call result:result];
  } else if ([@"getDeviceInfo" isEqualToString:call.method]) {
    [self _handleDeviceInfo:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)_handleInit:(FlutterMethodCall*)call result:(FlutterResult)result {
  _httpConnection = [[HttpConnection alloc] init];
  
  // TODO: pass argument
  [_httpConnection setTargetIp:@"192.168.1.1"];
}

- (void)_handleDeviceInfo:(FlutterMethodCall*)call result:(FlutterResult)result {
  [_httpConnection getDeviceInfo:^(const HttpDeviceInfo *info) {
    
    // TODO: catch errors
    
    result(@{
      @"model": info.model,
      @"firmwareVersion": info.firmware_version,
      @"serialNumber": info.serial_number
    });
  }];
}

@end
