//
//  WXCondition.m
//  SimpleWeather
//
//  Created by Admin on 6/30/16.
//  Copyright © 2016 Managam. All rights reserved.
//

#import "WXCondition.h"

#define MPS_TO_MPH 2.23694f

@implementation WXCondition

+ (NSDictionary *) imageMap {
    // 1
    static NSDictionary *_imageMap = nil;
    if (! _imageMap) {
        // 2
        _imageMap = @{
                      @"01d" : @"Images/Weather Icons/weather-clear",
                      @"02d" : @"Images/Weather Icons/weather-few",
                      @"03d" : @"Images/Weather Icons/weather-few",
                      @"04d" : @"Images/Weather Icons/weather-broken",
                      @"09d" : @"Images/Weather Icons/weather-shower",
                      @"10d" : @"Images/Weather Icons/weather-rain",
                      @"11d" : @"Images/Weather Icons/weather-tstorm",
                      @"13d" : @"Images/Weather Icons/weather-snow",
                      @"50d" : @"Images/Weather Icons/weather-mist",
                      @"01n" : @"Images/Weather Icons/weather-moon",
                      @"02n" : @"Images/Weather Icons/weather-few-night",
                      @"03n" : @"Images/Weather Icons/weather-few-night",
                      @"04n" : @"Images/Weather Icons/weather-broken",
                      @"09n" : @"Images/Weather Icons/weather-shower",
                      @"10n" : @"Images/Weather Icons/weather-rain-night",
                      @"11n" : @"Images/Weather Icons/weather-tstorm",
                      @"13n" : @"Images/Weather Icons/weather-snow",
                      @"50n" : @"Images/Weather Icons/weather-mist"
                      };
    }
    return _imageMap;
}

// 3
- (NSString *) imageName {
    return [WXCondition imageMap][self.icon];
}

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"dt",
             @"locationName": @"name",
             @"humidity": @"main.humidity",
             @"temperature": @"main.temp",
             @"tempHigh": @"main.temp_max",
             @"tempLow": @"main.temp_min",
             @"sunrise": @"sys.sunrise",
             @"sunset": @"sys.sunset",
             @"conditionDescription": @"weather.description",
             @"condition": @"weather.main",
             @"icon": @"weather.icon",
             @"windBearing": @"wind.deg",
             @"windSpeed": @"wind.speed"
             };
}

+ (NSValueTransformer *) dateJSONTransformer {
    // 1
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
    } reverseBlock:^(NSDate *date) {
        return [NSString stringWithFormat:@"%f", [date timeIntervalSince1970]];
    }];
}

// 2
+ (NSValueTransformer *) sunriseJSONTransformer {
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *) sunsetJSONTransformer {
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *) windSpeedJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num) {
        return @(num.floatValue * MPS_TO_MPH);
    } reverseBlock:^(NSNumber *speed) {
        return @(speed.floatValue / MPS_TO_MPH);
    }];
}

@end
