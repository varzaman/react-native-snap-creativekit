#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SnapCreativekit, NSObject)

RCT_EXTERN_METHOD(multiply:(float)a withB:(float)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(shareMedia:(NSString *)url 
                  uuid:(NSString *)uuid
                  options:(NSDictionary *)options
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)

@end
