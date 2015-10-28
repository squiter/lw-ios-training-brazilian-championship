//
//  TeamsTableViewController.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "TeamsTableViewController.h"

@interface TeamsTableViewController ()

@property (nonatomic, strong) NSArray *teams;

@end

@implementation TeamsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Clubes";
    
    [self loadTeams];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTeams {
    [BCAPIClient fetchTeams:^(NSArray<BCTeam *> *teams, NSInteger statusCode, NSError *error) {
        
        if (!error) {
            self.teams = [teams sortedArrayUsingSelector:@selector(compare:)];
        } else {
            NSLog(@"%@",error);
        }
        
        [self.tableView reloadData];
        
    }];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teams.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BCTeamTableViewCell *teamCell = [tableView dequeueReusableCellWithIdentifier:@"teamCell" forIndexPath:indexPath];
    
    // Configure the cell...
    BCTeam *team = self.teams[indexPath.row];
    teamCell.name.text = team.name;
    [teamCell.shield sd_setImageWithURL:(NSURL *)team.imageURL];

    return teamCell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToTeamDetail"]) {
        BCTeamDetailViewController *detailVC = segue.destinationViewController;
        BCTeam *team = self.teams[self.tableView.indexPathForSelectedRow.row];
        detailVC.team = team;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
