//
//  AppDelegate.h
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableArray *tagsMutableArray;
}
@property (nonatomic, retain) NSMutableArray *tagsMutableArray;
@property (strong, nonatomic) NSMutableArray *retrievedItems;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (strong, nonatomic) NSMutableArray *suggestedItemArray;
@property (strong, nonatomic) NSMutableArray *messagesArray;

@property (strong, nonatomic) UIWindow *window;

@end

