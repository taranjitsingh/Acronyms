//
//  ViewController.m
//  acromine
//
//  Created by Taranjit Lottey on 2/17/16.
//  Copyright © 2016 Taranjit Lottey. All rights reserved.
//


// *************************************************************************************************
// # MARK: Imports


#import "HomeScreen.h"

#import "DetailAcronymViewViewController.h"
#import "MBProgressHUD/MBProgressHUD.h"
#import "WebApiHandler.h"


// *************************************************************************************************
// # MARK: Private Interface


@interface HomeScreen () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>


@property (nonatomic, strong, readwrite) NSMutableArray *_arrAcronResult;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *txtAcronym;


@end


// *************************************************************************************************
// # MARK: Implementation


@implementation HomeScreen


- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self._arrAcronResult) {
        self._arrAcronResult = [NSMutableArray new];
    }
}


// *************************************************************************************************
// # MARK: Private Methods


- (void)_loadTableWithData:(id)data {
    [self._arrAcronResult removeAllObjects];
    NSArray *arrData = [[data objectAtIndex:0] objectForKey:@"lfs"];
    [self._arrAcronResult addObjectsFromArray:arrData];
    [self.tableView reloadData];
}


// *************************************************************************************************
// # MARK: IBActions


- (IBAction)screenTapped:(id)sender {
    [self.txtAcronym resignFirstResponder];
}


// *************************************************************************************************
// # MARK: Table View Datasource and Delegate Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self._arrAcronResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSDictionary *fullForm = [self._arrAcronResult objectAtIndex:indexPath.row];
    cell.textLabel.text = [fullForm objectForKey:@"lf"];
    NSString *detailText = [NSString stringWithFormat:@"Frequency :  %@ \t Since : %@",
                            [fullForm objectForKey:@"freq"],
                            [fullForm objectForKey:@"since"]];
    cell.detailTextLabel.text = detailText;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"DetailView" sender:nil];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}



// *************************************************************************************************
// # MARK: TextField Delegates


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *acronym = self.txtAcronym.text;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WebApiHandler sharedInstance] getResultsForAcronym:acronym response:^(id response, id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _loadTableWithData:response];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
    [textField resignFirstResponder];
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailView"]) {
        DetailAcronymViewViewController *detailView = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSDictionary *fullForm = [self._arrAcronResult objectAtIndex:path.row];
        NSArray *arrVars = [fullForm objectForKey:@"vars"];
        detailView.arrDetailData = arrVars;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
