//
//  topItemsTVC.m
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import "topItemsTVC.h"

@interface topItemsTVC ()

@end

@implementation topItemsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    dataModel *data = [[dataModel alloc] init];

//   NSLog(@"%lu", (unsigned long)data.topitems.count);
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    [[dataManager sharedManager] retrieveDataWithCompletion:^(dataModel *data, NSError *error) {
//       cell.textLabel.text = [data.topitems objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", data.city];
    }];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];

    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [app.retrievedItems addObject:cell.textLabel.text];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [app.retrievedItems removeObject:cell.textLabel.text];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
