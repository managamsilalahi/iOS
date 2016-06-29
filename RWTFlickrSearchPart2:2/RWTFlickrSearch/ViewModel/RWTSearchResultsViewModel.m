//
//  RWTSearchResultsViewModel_RWTSearchResultsViewModel.h
//  RWTFlickrSearch
//
//  Created by Admin on 6/29/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "RWTSearchResultsItemViewModel.h"

@implementation RWTSearchResultsViewModel

- (instancetype) initWithSearchResults: (RWTFlickrSearchResults *) results
                              services: (id<RWTViewModelServices>) services {
    if (self = [super init]) {
        _title = results.searchString;
        _searchResults = [results.photos linq_select:^id(RWTFlickrPhoto *photo) {
            return [[RWTSearchResultsItemViewModel alloc] initWithPhoto:photo services:services];
        }];
    }
    return self;
}
@end
