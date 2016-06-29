//
//  RWTSearchResultsViewModel_RWTSearchResultsViewModel.h
//  RWTFlickrSearch
//
//  Created by Admin on 6/29/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"

@implementation RWTSearchResultsViewModel

- (instancetype) initWithSearchResults: (RWTFlickrSearchResults *) results
                              services: (id<RWTViewModelServices>) services {
    if (self = [super init]) {
        _title = results.searchString;
        _searchResults = results.photos;
    }
    return self;
}
@end
