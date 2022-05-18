//
//  RCTWeatherServicesModule.m
//  SimpleWeatherApp
//
//  Created by Michael Nguyen on 5/17/22.
//

#import "RCTWeatherServicesModule.h"
#import <React/RCTLog.h>
#import "SimpleWeatherApp-Swift.h"

@implementation RCTWeatherServicesModule

// export a module named RCTWeatherServicesModule
RCT_EXPORT_MODULE(MNWeatherServicesModule);

RCT_EXPORT_METHOD(getForecast:(NSString *)city days:(NSString *)daysString)
{
    NSInteger days = [daysString intValue];
    WeatherService* service = [WeatherService shared];

    [service forecastWeatherRNWithCity:city numDays:days completion:^(BOOL success, NSData* data) {

        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        [[RNEventEmitter emitter] sendEventWithName:@"onReceiveForecasts" body:@{@"response": jsonString} ];
    }];
}



@end

