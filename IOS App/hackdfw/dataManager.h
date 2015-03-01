//
//  dataManager.h
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataModel.h"
#import "ViewController.h"

typedef void (^ResultBlock)(dataModel *info, NSError *error);

@interface dataManager : NSObject 

#pragma mark - Remote

- (void)retrieveDataWithCompletion:(ResultBlock)completionBlock;
- (void)postDataWithCompletion:(ResultBlock)completionBlock;

#pragma mark - Singleton

+ (instancetype)sharedManager;

@end
