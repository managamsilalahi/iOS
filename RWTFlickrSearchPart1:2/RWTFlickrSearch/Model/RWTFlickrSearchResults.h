//
//  RWTFlickrSearchResults.h
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrSearchResults : NSObject

@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSArray *photos;
@property (nonatomic) NSUInteger totalResults;

@end
