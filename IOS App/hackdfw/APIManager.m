//
//  APIManager.m
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import "APIManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@implementation APIManager

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self)
        return nil;
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return self;
}

#pragma mark - Singleton Methods

+ (instancetype)sharedManager
{
    static dispatch_once_t pred;
    static APIManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{ _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://azrotech.com"]]; });
    return _sharedManager;
}

@end
