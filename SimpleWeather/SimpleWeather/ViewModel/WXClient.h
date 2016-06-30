//
//  WXClient.h
//  SimpleWeather
//
//  Created by Admin on 6/30/16.
//  Copyright © 2016 Managam. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface WXClient : NSObject

- (RACSignal *) fetchJSONFromURL: (NSURL *) url;
- (RACSignal *) fetchCurrentConditionsForLocation: (CLLocationCoordinate2D) coordinate;
- (RACSignal *) fetchHourlyForecastForLocation: (CLLocationCoordinate2D) coordinate;
- (RACSignal *) fetchDailyForecastForLocation: (CLLocationCoordinate2D) coordinate;

@end
