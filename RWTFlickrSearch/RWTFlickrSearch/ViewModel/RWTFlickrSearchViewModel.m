//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"

@implementation RWTFlickrSearchViewModel

- (instancetype) init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize {
    self.searchText = @"Search text";
    self.title = @"Flickr Search";
}

@end
