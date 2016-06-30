//
//  WXManager.h
//  SimpleWeather
//
//  Created by Admin on 6/30/16.
//  Copyright © 2016 Managam. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa.h>

// 1
#import "WXCondition.h"

@interface WXManager : NSObject <CLLocationManagerDelegate>

// 2
+ (instancetype) sharedManager;

// 3
@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) WXCondition *currentCondition;
@property (nonatomic, strong, readonly) NSArray *hourlyForecast;
@property (nonatomic, strong, readonly) NSArray *dailyForecast;

// 4
- (void) findCurrentLocation;

@end
