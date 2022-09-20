//
//  StorageController.h
//  ricoh_theta
//
//  Created by Dimitri Dessus on 20/09/2022.
//

#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import "HttpConnection.h"

NS_ASSUME_NONNULL_BEGIN

@interface StorageController : NSObject

@property(readonly, nonatomic) FlutterResult result;
@property(readonly, nonatomic) HttpConnection *httpConnection;

- (void)getStorageInfo;
- (void)getImageInfoes;
- (void)setResult:(FlutterResult _Nonnull)result;
- (void)setHttpConnection:(HttpConnection * _Nonnull)httpConnection;

@end

NS_ASSUME_NONNULL_END
