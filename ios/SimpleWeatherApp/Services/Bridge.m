//
//  Bridge.m
//  SimpleWeatherApp
//
//  Created by Michael Nguyen on 5/16/22.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(RNEventEmitter, RCTEventEmitter)

RCT_EXTERN_METHOD(supportedEvents)

@end
