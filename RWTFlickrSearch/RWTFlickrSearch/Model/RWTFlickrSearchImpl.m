//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"

@implementation RWTFlickrSearchImpl

- (RACSignal *) flickrSearchSignal: (NSString *) searchString {
    return [[[[RACSignal empty] logAll] delay: 2.0] logAll];
}

@end
