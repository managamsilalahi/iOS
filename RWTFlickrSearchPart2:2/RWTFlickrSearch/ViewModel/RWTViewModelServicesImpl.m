//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"

@interface RWTViewModelServicesImpl()

@property (strong, nonatomic) RWTFlickrSearchImpl *searchService;

@end

@implementation RWTViewModelServicesImpl

- (instancetype) init {
    if (self = [super init]) {
        _searchService = [RWTFlickrSearchImpl new];
    }
    return self;
}

- (id<RWTFlickrSearch>) getFlickrSearchService {
    return self.searchService;
}

@end
