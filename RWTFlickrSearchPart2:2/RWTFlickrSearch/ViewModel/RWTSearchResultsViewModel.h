//
//  RWTSearchResultsViewModel
//  RWTFlickrSearch
//
//  Created by Admin on 6/29/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServices.h"
#import "RWTFlickrSearchResults.h"

@interface RWTSearchResultsViewModel : NSObject

- (instancetype) initWithSearchResults: (RWTFlickrSearchResults *) results
                              services: (id<RWTViewModelServices>) services;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *searchResults;

@end
