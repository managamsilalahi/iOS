//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by Admin on 6/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"
#import "RWTSearchResultsViewController.h"

@interface RWTViewModelServicesImpl()

@property (strong, nonatomic) RWTFlickrSearchImpl *searchService;
@property (weak, nonatomic) UINavigationController *navigationController;

@end

@implementation RWTViewModelServicesImpl

- (instancetype) initWithNavigationController:(UINavigationController *) navigationController {
    if (self = [super init]) {
        _searchService = [RWTFlickrSearchImpl new];
        _navigationController = navigationController;
    }
    return self;
}

- (void) pushViewModel:(id)viewModel {
    id viewController;
    
    if ([viewModel isKindOfClass:RWTSearchResultsViewModel.class]) {
        viewController = [[RWTSearchResultsViewController alloc] initWithViewModel:viewModel];
    } else {
        NSLog(@"An unknown ViewModel was pushed!");
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

/*- (instancetype) init {
    if (self = [super init]) {
        _searchService = [RWTFlickrSearchImpl new];
    }
    return self;
}*/

- (id<RWTFlickrSearch>) getFlickrSearchService {
    return self.searchService;
}

@end
