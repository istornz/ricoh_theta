#import "RicohThetaPlugin.h"
#import "HttpConnection.h"
#import "PictureController.h"
#import "StorageController.h"
#import "Constants.h"

FlutterEventSink livePreviewStreamEventSink;
PictureController *pictureController;
HttpConnection *httpConnection;
StorageController *storageController;

@implementation RicohThetaPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
                                   methodChannelWithName:@"ricoh_theta"
                                   binaryMessenger:[registrar messenger]];
  
  LivePreviewStreamHandler *livePreviewStreamHandler =
  [[LivePreviewStreamHandler alloc] init];
  FlutterEventChannel *livePreviewChannel = [FlutterEventChannel eventChannelWithName:@"ricoh_theta/preview"
                                                                      binaryMessenger:[registrar messenger]];
  [livePreviewChannel setStreamHandler:livePreviewStreamHandler];
  
  RicohThetaPlugin* instance = [[RicohThetaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  
  httpConnection = [[HttpConnection alloc] init];
  pictureController = [[PictureController alloc] init];
  storageController = [[StorageController alloc] init];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  [self bindResultToControllers:result];
  
  if ([@"setTargetIp" isEqualToString:call.method]) {
    [self _handleSetTargetIp:call result:result];
  } else if ([@"disconnect" isEqualToString:call.method]) {
    [self _handleDisconnect:call result:result];
  } else if ([@"startLiveView" isEqualToString:call.method]) {
    [self _handleStartLiveView:call result:result];
  } else if ([@"batteryLevel" isEqualToString:call.method]) {
    [self _handleBatteryLevel:call result:result];
  } else if ([@"getStorageInfo" isEqualToString:call.method]) {
    [self _handleStorageInfo:call result:result];
  } else if ([@"getImageInfoes" isEqualToString:call.method]) {
    [self _handleGetImageInfoes:call result:result];
  } else if ([@"getDeviceInfo" isEqualToString:call.method]) {
    [self _handleDeviceInfo:call result:result];
  } else if ([@"takePicture" isEqualToString:call.method]) {
    [self _handleTakePicture:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)_handleBatteryLevel:(FlutterMethodCall*)call result:(FlutterResult)result {
  result([httpConnection getBatteryLevel]);
}

- (void)_handleDisconnect:(FlutterMethodCall*)call result:(FlutterResult)result {
  [httpConnection close:^{
    result(nil);
  }];
}

- (void)_handleStartLiveView:(FlutterMethodCall*)call result:(FlutterResult)result {
  [pictureController startLiveView];
}

- (void)_handleGetImageInfoes:(FlutterMethodCall*)call result:(FlutterResult)result {
  [storageController getImageInfoes];
}

- (void)_handleTakePicture:(FlutterMethodCall*)call result:(FlutterResult)result {
  [pictureController takePicture];
}

- (void)_handleStorageInfo:(FlutterMethodCall*)call result:(FlutterResult)result {
  [storageController getStorageInfo];
}

- (void)_handleSetTargetIp:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString *ipAddress = call.arguments[@"ipAddress"];
  
  if (!ipAddress) {
    result([FlutterError errorWithCode:@"MISSING_IP_ADDRESS" message:@"ip address need to be specified" details:nil]);
  }
  
  [httpConnection setTargetIp:ipAddress];
  [self bindHttpConnectionToControllers];
  result(nil);
}

- (void)bindResultToControllers:(FlutterResult)result {
  [pictureController setResult:result];
  [storageController setResult:result];
}

- (void)bindHttpConnectionToControllers {
  [pictureController setHttpConnection:httpConnection];
  [storageController setHttpConnection:httpConnection];
}

- (void)_handleDeviceInfo:(FlutterMethodCall*)call result:(FlutterResult)result {
  [httpConnection getDeviceInfo:^(const HttpDeviceInfo *info) {
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


@implementation LivePreviewStreamHandler
- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
  livePreviewStreamEventSink = eventSink;
  [pictureController setLivePreviewEventSink:eventSink];
  return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
  livePreviewStreamEventSink = nil;
  [pictureController setLivePreviewEventSink:livePreviewStreamEventSink];
  return nil;
}
@end
