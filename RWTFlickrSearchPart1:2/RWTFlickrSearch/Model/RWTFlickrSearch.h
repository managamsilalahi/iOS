//
//  RWTFlickrSearch.h
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa/ReactiveCocoa.h"

@protocol RWTFlickrSearch <NSObject>

- (RACSignal *) flickrSearchSignal: (NSString *) searchString;

@end
