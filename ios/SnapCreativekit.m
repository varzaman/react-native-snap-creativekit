#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SnapCreativekit, NSObject)

RCT_EXTERN_METHOD(shareMedia:(NSString *)url 
                  uuid:(NSString *)uuid
                  options:(NSDictionary *)options
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(shareLens:(NSString *)uuid
                  options:(NSDictionary *)options
                  launchData:(NSDictionary *)launchData
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(shareSticker:(NSString *)url
                  options:(NSDictionary *)options
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)
@end
