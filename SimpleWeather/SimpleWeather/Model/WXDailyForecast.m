//
//  WXDailyForecast.m
//  SimpleWeather
//
//  Created by Admin on 6/30/16.
//  Copyright © 2016 Managam. All rights reserved.
//

#import "WXDailyForecast.h"

@implementation WXDailyForecast

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    // 1
    NSMutableDictionary *paths = [[super JSONKeyPathsByPropertyKey] mutableCopy];
    // 2
    paths[@"tempHigh"] = @"temp.max";
    paths[@"tempLow"] = @"temp.min";
    // 3
    return paths;
}

@end
