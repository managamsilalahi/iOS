//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation RWTFlickrSearchViewModel

- (instancetype) init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize {
    self.title = @"Flickr Search";
    //self.searchText = @"Search text";
    
    RACSignal *validSearchSignal =
    [[RACObserve(self, searchText)
      map:^id(NSString *text) {
          return @(text.length > 3);
      }]
     distinctUntilChanged];
    
    [validSearchSignal subscribeNext:^(id x) {
        NSLog(@"Search text is valid %@", x);
    }];
    
    self.executeSearch = [[RACCommand alloc] initWithEnabled: validSearchSignal signalBlock: ^RACSignal *(id input) {
        return [self executeSearchSignal];
    }];
    
    
    
}

- (RACSignal *) executeSearchSignal {
    return [[[[RACSignal empty] logAll] delay: 2.0] logAll];
}

@end
