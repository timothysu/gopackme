//
//  dataManager.m
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import "dataManager.h"
#import "APIManager.h"

@interface dataManager ()

@property (nonatomic, weak) APIManager *api;

@end

@implementation dataManager

#pragma mark - Remote

- (void)retrieveDataWithCompletion:(ResultBlock)completionBlock
{
    [_api GET:@"v1/lists/supported/shop/flights/origins-destinations?destinationcountry=AR%20HTTP/1.1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict = responseObject;
        
        dataModel *data = [[dataModel alloc] initWithDictionary:responseDict error:nil];
        
        if(completionBlock)
            completionBlock(data, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to retrieve data: %@", error);
        
        if(completionBlock)
            completionBlock(nil, error);
    }];
}

//- (void)postDataWithCompletion:(ResultBlock)completionBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager POST:@"https://api.sabre.com/v1/auth/327p7pytsk7hxv2f" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//}


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if(!self)
        return nil;
    
    self.api = [APIManager sharedManager];
    
    return self;
}

#pragma mark - Singleton

+ (instancetype)sharedManager
{
    static dispatch_once_t pred;
    static dataManager *manager = nil;
    
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    return manager;
}

@end
