//
//  StorageController.m
//  ricoh_theta
//
//  Created by Dimitri Dessus on 20/09/2022.
//

#import "StorageController.h"

@implementation StorageController

- (void)getStorageInfo {
  HttpStorageInfo *info = [_httpConnection getStorageInfo];
  
  if (!info) {
    _result([FlutterError errorWithCode:@"GET_STORAGE_ERROR" message:@"unable to get storage details" details:nil]);
  }
  
  _result(@{
    @"maxCapacity": @(info.max_capacity),
    @"freeSpaceInBytes": @(info.free_space_in_bytes),
    @"freeSpaceInImages": @(info.free_space_in_images),
    @"imageWidth": @(info.image_width),
    @"imageHeight": @(info.image_height),
  });
}

- (void)getImageInfoes {
  NSArray *imageInfoes = [_httpConnection getImageInfoes];
  
  NSUInteger maxCount = MIN(imageInfoes.count, 30);
  NSMutableArray *result = [NSMutableArray alloc];
  for (NSUInteger i = 0; i < maxCount; ++i) {
    HttpImageInfo *info = [imageInfoes objectAtIndex:i];
    
    [result addObject:@{
      @"fileFormat":  [self formatTypeToString:info.file_format],
      @"fileSize": @(info.file_size),
      @"imagePixWidth": @(info.image_pix_width),
      @"imagePixHeight": @(info.image_pix_height),
      @"fileName": info.file_name,
      @"captureDate": @([info.capture_date timeIntervalSince1970]),
      @"fileId": info.file_id,
    }];
  }
}

- (NSString *)formatTypeToString:(NSInteger)formatType {
    switch(formatType) {
        case CODE_JPEG:
            return @"CODE_JPEG";
        case CODE_MPEG:
            return @"CODE_MPEG";
        default:
        return @"UNKNOWN";
    }
}

# pragma mark - Setters -

- (void)setHttpConnection:(HttpConnection * _Nonnull)httpConnection {
  _httpConnection = httpConnection;
}

- (void)setResult:(FlutterResult _Nonnull)result {
  _result = result;
}

@end
