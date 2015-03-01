//
//  ViewController.h
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataModel.h"
#import "dataManager.h"
#import "APIManager.h"
#import <AFNetworking/AFNetworking.h>
#import <AMTagListView.h>
#import <AMTagView.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    
    NSDictionary *dataDictionary;

    NSString *tagsString;
}

@property (nonatomic, strong) IBOutlet UITextField *startDate;
@property (nonatomic, strong) IBOutlet UITextField *endDate;
@property (nonatomic, strong) IBOutlet UITextField *city;
@property (nonatomic, strong) IBOutlet UITextField *state;
@property (nonatomic, strong) IBOutlet UITextField *tagsTextField;
@property (nonatomic, strong) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet AMTagListView	*tagListView;
@property (nonatomic, strong) AMTagView *selection;

@property(nonatomic,retain) NSDictionary *dataDictionary;

- (IBAction)submit:(id)sender;
- (IBAction)addTag:(id)sender;

@end

