//
//  BCMatchesTableViewController.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "BCMatchesTableViewController.h"

@interface BCMatchesTableViewController ()

@property (nonatomic, strong) NSArray *matches;

@end

@implementation BCMatchesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Patidas";
    
    [self loadMatches];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMatches {
    [BCAPIClient fetchMatches:^(NSArray<BCMatch *> *matches, NSInteger statusCode, NSError *error) {
        
        if (!error) {
            self.matches = matches;
        } else {
            NSLog(@"%@",error);
        }
        
        [self.tableView reloadData];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = 0;
    
    for (NSUInteger i = 0; i < self.matches.count; i++) {
        if (i == 0) {
            count++;
        }else{
            NSUInteger j = i - 1;
            BCMatch *current = self.matches[i];
            BCMatch *previus = self.matches[j];
            if (current.mRound != previus.mRound) {
                count++;
            }
        }
    }
    return count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return all elements for this section
//    NSMutableArray<BCMatch *> *matches_in_section;
//
//    for (BCMatch * m in self.matches) {
//        if (m.mRound.integerValue == section) {
//            [matches_in_section arrayByAddingObject:m];
//        }
//    }
//    return matches_in_section.count;
    return self.matches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BCMatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"matchCell" forIndexPath:indexPath];
    
    BCMatch *match = self.matches[indexPath.row];
    
    //if (match.mRound.integerValue == indexPath.section) {
        // Configure the cell...
        cell.mDate.text = match.formattedDate;
        cell.location.text = match.location;
        cell.homeTeamName.text = match.homeTeam.name;
        cell.homeTeamScore.text = match.homeTeamScore.stringValue;
        [cell.homeTeamSheild sd_setImageWithURL:(NSURL *) match.homeTeam.imageURL];
        cell.vistitorTeamName.text = match.visitorTeam.name;
        cell.visitorTeamScore.text = match.visitorTeamScore.stringValue;
        [cell.visitorTeamSheild sd_setImageWithURL:(NSURL *) match.visitorTeam.imageURL];
    //}
    //TODO: select the righ cell by indexPath.section
    return cell;
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
