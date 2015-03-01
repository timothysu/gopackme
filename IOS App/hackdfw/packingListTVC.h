//
//  packingListTVC.h
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MCSwipeTableViewCell.h"

@interface packingListTVC : UITableViewController

@property (nonatomic, strong) NSArray *tableArray;
@property (nonatomic, strong) IBOutlet UITextField *addTextField;

- (IBAction)addItem:(id)sender;

@end
