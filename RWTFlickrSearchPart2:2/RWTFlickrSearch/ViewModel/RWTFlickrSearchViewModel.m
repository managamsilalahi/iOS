//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTSearchResultsViewModel.h"

@interface RWTFlickrSearchViewModel()

@property (nonatomic, weak) id<RWTViewModelServices> services;

@end

@implementation RWTFlickrSearchViewModel

- (instancetype) initWithService:(id<RWTViewModelServices>)services {
    self = [super init];
    if (self) {
        _services = services;
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
    //return [[self.services getFlickrSearchService] flickrSearchSignal:self.searchText];
    /*RACSignal *flickrSearchService = [[[self.services getFlickrSearchService] flickrSearchSignal:self.searchText] logAll];
    return flickrSearchService;*/
    RACSignal *flickrSearchService = [[[self.services getFlickrSearchService] flickrSearchSignal:self.searchText] doNext:^(id result) {
        RWTSearchResultsViewModel *resultsViewModel = [[RWTSearchResultsViewModel alloc] initWithSearchResults:result services:self.services];
        [self.services pushViewModel:resultsViewModel];
    }];
    return flickrSearchService;
}

@end
