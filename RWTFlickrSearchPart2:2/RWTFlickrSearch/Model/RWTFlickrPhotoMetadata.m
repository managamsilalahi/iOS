//
//  RWTFlickrPhotoMetadata.m
//  RWTFlickrSearch
//
//  Created by Admin on 6/29/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrPhotoMetadata.h"

@implementation RWTFlickrPhotoMetadata

- (NSString *) description {
    NSString *description = [NSString stringWithFormat:@"metadata: comments=%lU, faves=%lU", (unsigned long)self.comments, (unsigned long)self.favorites];
    return description;
}

@end
