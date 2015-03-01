//
//  suggestedItemsTVC.m
//  hackdfw
//
//  Created by Jacob Banks on 3/1/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import "suggestedItemsTVC.h"

@interface suggestedItemsTVC ()

@end

@implementation suggestedItemsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:239.0/255.0 green:137.0/255.0 blue:45.0/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //change the nav bar color
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    //change the background color
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    //Set nav bar color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //change the nav bar colour
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    //change the background colour
    self.navigationController.navigationBar.translucent = NO;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"%@", app.suggestedItemArray);
    
    return app.suggestedItemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Configure the cell...
    cell.textLabel.text = [app.suggestedItemArray objectAtIndex:indexPath.row];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
        [app.retrievedItems addObject:cell.textLabel.text];
        [app.suggestedItemArray removeObject:cell.textLabel.text];
    
    
    
    [self.tableView reloadData];
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
