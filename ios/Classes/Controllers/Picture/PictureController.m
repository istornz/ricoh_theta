//
//  PictureController.m
//  ricoh_theta
//
//  Created by Dimitri Dessus on 19/09/2022.
//

#import "PictureController.h"

@implementation PictureController

-(id)init {
  if ( self = [super init] ) {
    _frameCount = 0;
  }
  return self;
}

- (void)takePicture {
  HttpImageInfo *info = [_httpConnection takePicture];
  
  if (!info) {
    _result([FlutterError errorWithCode:@"PICTURE_TAKE_ERROR" message:@"unable to take picture" details:nil]);
  }
  
  NSData *thumbData = [_httpConnection getThumb:info.file_id];
  UIImage *image = [UIImage imageWithData:thumbData];
  
  NSString *uuid = [[NSUUID UUID] UUIDString];
  NSString *tmpFile = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ricoh_thetha_preview.jpg", uuid]];
  bool success = [UIImageJPEGRepresentation(image, 1.0) writeToFile:tmpFile atomically:YES];
  if (!success) {
    _result([FlutterError errorWithCode:@"WRITE_FAILED" message:@"unable to write file" details:nil]);
    return;
  }
}

- (void)startLiveView {
  [_httpConnection startLiveView:^(NSData *frameData) {
    // TODO: Send to surface ???
    
    // self->_frameCount++;
    // if (self->_livePreviewEventSink && self->_frameCount >= 15) {
    //   self->_livePreviewEventSink(frameData);
    //   self->_frameCount = 0;
    // }

    self->_livePreviewEventSink(frameData);
  }];
}

- (void)resumeLiveView {
  [_httpConnection resumeLiveView];
}

- (void)pauseLiveView {
  [_httpConnection pauseLiveView];
}

- (void)stopLiveView {
  [_httpConnection stopLiveView];
}

# pragma mark - Setters -

- (void)setHttpConnection:(HttpConnection * _Nonnull)httpConnection {
  _httpConnection = httpConnection;
}

- (void)setResult:(FlutterResult _Nonnull)result {
  _result = result;
}

- (void)setLivePreviewEventSink:(FlutterEventSink _Nonnull)livePreviewEventSink {
  _livePreviewEventSink = livePreviewEventSink;
}

@end
