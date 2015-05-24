//
//  ViewController.m
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@end

@implementation ViewController
@synthesize dataDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [[dataManager sharedManager] retrieveDataWithCompletion:^(dataModel *info, NSError *error) {
//        NSLog(@"%@ hi", info.CityName);
//    }];

    [self.tagsTextField setDelegate:self];

    [[AMTagView appearance] setTagLength:10];
    [[AMTagView appearance] setTextPadding:14];
    [[AMTagView appearance] setTextFont:[UIFont fontWithName:@"Futura" size:14]];
    [[AMTagView appearance] setTagColor:UIColorFromRGB(0x1f9dd6)];

    [[AMTagView appearance] setAccessoryImage:[UIImage imageNamed:@"close"]];
    
    CALayer * layer = [_submitButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(viewTapped:)];
    tap.numberOfTapsRequired = 1;
    [self.tagListView addGestureRecognizer:tap];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)addTag:(id)sender {
    
    if (![self.tagsTextField.text isEqualToString:@""] && ![self.tagsTextField.text isEqualToString:@" "]) {
        [self.tagListView addTag:_tagsTextField.text];
    
        AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        tagsString = _tagsTextField.text;
        tagsString = [tagsString stringByReplacingOccurrencesOfString:@" " withString:@""];
        [app.tagsMutableArray addObject:tagsString];
        NSLog(@"tags are: %@", tagsString);
    
        [self.tagsTextField setText:@""];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (![self.tagsTextField.text isEqualToString:@""] && ![self.tagsTextField.text isEqualToString:@" "]) {

        [self.tagListView addTag:_tagsTextField.text];
        
        AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        tagsString = _tagsTextField.text;
        tagsString = [tagsString stringByReplacingOccurrencesOfString:@" " withString:@""];
        [app.tagsMutableArray addObject:tagsString];
        NSLog(@"tags are: %@", tagsString);
    
        [self.tagsTextField setText:@""];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submit:(id)sender {
    
//    NSString *startDateString = _startDate.text;
//    NSString *endDateString = _endDate.text;
    NSString *cityString = _city.text;
    NSString *stateString = _state.text;

    stateString = [[stateString stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    
    [[dataManager sharedManager] postDataWithCity:cityString andState:stateString];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_startDate resignFirstResponder];
    [_endDate resignFirstResponder];
    [_city resignFirstResponder];
    [_state resignFirstResponder];
    [_tagsTextField resignFirstResponder];

}

-(void)viewTapped:(UITapGestureRecognizer *)recognizer {
    [_startDate resignFirstResponder];
    [_endDate resignFirstResponder];
    [_city resignFirstResponder];
    [_state resignFirstResponder];
    [_tagsTextField resignFirstResponder];
}

@end
