#import "RicohThetaPlugin.h"
#import "HttpConnection.h"
#import "Constants.h"

@implementation RicohThetaPlugin {
  HttpConnection *_httpConnection;
}

-(id)init {
    if ( self = [super init] ) {
      _httpConnection = [[HttpConnection alloc] init];
    }
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"ricoh_theta"
            binaryMessenger:[registrar messenger]];
  RicohThetaPlugin* instance = [[RicohThetaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"setTargetIp" isEqualToString:call.method]) {
    [self _handleSetTargetIp:call result:result];
  } else if ([@"disconnect" isEqualToString:call.method]) {
    [self _handleDisconnect:call result:result];
  } else if ([@"batteryLevel" isEqualToString:call.method]) {
    [self _handleBatteryLevel:call result:result];
  } else if ([@"getDeviceInfo" isEqualToString:call.method]) {
    [self _handleDeviceInfo:call result:result];
  } else if ([@"takePicture" isEqualToString:call.method]) {
    [self _handleTakePicture:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)_handleBatteryLevel:(FlutterMethodCall*)call result:(FlutterResult)result {
  result([_httpConnection getBatteryLevel]);
}

- (void)_handleDisconnect:(FlutterMethodCall*)call result:(FlutterResult)result {
  [_httpConnection close:^{
    result(nil);
  }];
}

- (void)_handleTakePicture:(FlutterMethodCall*)call result:(FlutterResult)result {
  HttpImageInfo *info = [_httpConnection takePicture];
  
  if (!info) {
    result([FlutterError errorWithCode:@"PICTURE_TAKE_ERROR" message:@"unable to take picture" details:nil]);
  }
  
  NSData *thumbData = [_httpConnection getThumb:info.file_id];
  UIImage *image = [UIImage imageWithData:thumbData];
  
  NSString *uuid = [[NSUUID UUID] UUIDString];
  NSString *tmpFile = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ricoh_thetha_preview.jpg", uuid]];
  bool success = [UIImageJPEGRepresentation(image, 1.0) writeToFile:tmpFile atomically:YES];
  if (!success) {
      result([FlutterError errorWithCode:@"IOError" message:@"unable to write file" details:nil]);
      return;
  }
  
  result(tmpFile);
}

- (void)_handleSetTargetIp:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString *ipAddress = call.arguments[@"ipAddress"];
  
  if (!ipAddress) {
    result([FlutterError errorWithCode:@"MISSING_IP_ADDRESS" message:@"ip address need to be specified" details:nil]);
  }
  
  [_httpConnection setTargetIp:ipAddress];
  result(nil);
}

- (void)_handleDeviceInfo:(FlutterMethodCall*)call result:(FlutterResult)result {
    [_httpConnection getDeviceInfo:^(const HttpDeviceInfo *info) {
      if (!info) {
        result([FlutterError errorWithCode:@"INFO_ERROR" message:@"unable to retrieve device info" details:nil]);
        return;
      }
      
      result(@{
        @"model": info.model,
        @"firmwareVersion": info.firmware_version,
        @"serialNumber": info.serial_number
      });
    }];
}

@end
