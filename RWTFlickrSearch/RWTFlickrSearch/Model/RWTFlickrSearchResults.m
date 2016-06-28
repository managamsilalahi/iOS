//
//  RWTFlickrSearchResults.m
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResults.h"

@implementation RWTFlickrSearchResults

- (NSString *) description {
    return [NSString stringWithFormat:@"searchString=%@, totalresults=%lU, photos=%@", self.searchString, (unsigned long)self.totalResults, self.photos];
}

@end
