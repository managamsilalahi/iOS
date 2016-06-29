//
//  RWTFlickrSearchImpl.h
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrSearch.h"

@interface RWTFlickrSearchImpl : NSObject <RWTFlickrSearch>

- (RACSignal *) flickrSearchSignal: (NSString *) searchString;

@end
