//
//  DetailAcronymViewViewController.m
//  Acromine
//
//  Created by Taranjit Lottey on 2/18/16.
//  Copyright © 2016 Taranjit Lottey. All rights reserved.
//

// *************************************************************************************************
// # MARK: Imports


#import "DetailAcronymViewViewController.h"


// *************************************************************************************************
// # MARK: Private Interface


@interface DetailAcronymViewViewController ()
@end


// *************************************************************************************************
// # MARK: Implementation


@implementation DetailAcronymViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// *************************************************************************************************
// # MARK: Table View Datasource and Delegate Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrDetailData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSDictionary *fullForm = [self.arrDetailData objectAtIndex:indexPath.row];
    cell.textLabel.text = [fullForm objectForKey:@"lf"];
    NSString *detailText = [NSString stringWithFormat:@"Frequency :  %@ \t Since : %@",
                            [fullForm objectForKey:@"freq"],
                            [fullForm objectForKey:@"since"]];
    cell.detailTextLabel.text = detailText;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}



@end
