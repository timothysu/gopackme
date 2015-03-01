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
//        _cityLabel.text = [NSString stringWithFormat:@"%@", info.cityNames];
//    }];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_startDate setInputView:datePicker];

    UIDatePicker *datePicker2 = [[UIDatePicker alloc]init];
    [datePicker2 setDate:[NSDate date]];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    [datePicker2 addTarget:self action:@selector(dateTextField2:) forControlEvents:UIControlEventValueChanged];
    [_endDate setInputView:datePicker2];

    [self.tagsTextField setDelegate:self];

    [[AMTagView appearance] setTagLength:10];
    [[AMTagView appearance] setTextPadding:14];
    [[AMTagView appearance] setTextFont:[UIFont fontWithName:@"Futura" size:14]];
    [[AMTagView appearance] setTagColor:UIColorFromRGB(0x1f9dd6)];

    [[AMTagView appearance] setAccessoryImage:[UIImage imageNamed:@"close"]];
    
    CALayer * layer = [_submitButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)addTag:(id)sender {
    
    [self.tagListView addTag:_tagsTextField.text];
    
    AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    tagsString = _tagsTextField.text;
    
    tagsString = [tagsString stringByReplacingOccurrencesOfString:@" " withString:@""];

    [app.tagsMutableArray addObject:tagsString];
    
    NSLog(@"tags are: %@", tagsString);
    
    [self.tagsTextField setText:@""];
}


- (void)dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)_startDate.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _startDate.text = [NSString stringWithFormat:@"%@", dateString];
}

- (void)dateTextField2:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)_endDate.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _endDate.text = [NSString stringWithFormat:@"%@", dateString];
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

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters;
    
    AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    parameters = @{@"city": cityString, @"state": stateString, @"tags": app.tagsMutableArray};
    
    [manager POST:@"http://mohawkvm.cloudapp.net/request" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
        NSDictionary *feed = responseObject;
        
        id fuckBitchesGetMoney = [feed objectForKey:@"titems"];
        id soManyBitches = [feed objectForKey:@"sitems"];
        
        [app.retrievedItems addObjectsFromArray:fuckBitchesGetMoney];
        [app.suggestedItemArray addObjectsFromArray:soManyBitches];
        
        NSLog(@"%@ asianChicks", fuckBitchesGetMoney);
        NSLog(@"%@ asianChicks", soManyBitches);

        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_startDate resignFirstResponder];
    [_endDate resignFirstResponder];
    [_city resignFirstResponder];
    [_state resignFirstResponder];
    [_tagsTextField resignFirstResponder];

}

@end
