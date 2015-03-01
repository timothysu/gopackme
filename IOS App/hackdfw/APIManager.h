//
//  APIManager.h
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface APIManager : AFHTTPRequestOperationManager

+ (instancetype)sharedManager;

@end
