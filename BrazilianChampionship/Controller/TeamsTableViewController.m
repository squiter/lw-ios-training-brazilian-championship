//
//  TeamsTableViewController.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "TeamsTableViewController.h"

@interface TeamsTableViewController () <UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *teams;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation TeamsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Clubes";
    
    self.searchResults = @[];
        
    [self loadTeams];
    [self setupSearchController];
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
    return self.searchController.isActive ? self.searchResults.count : self.teams.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BCTeamTableViewCell *teamCell = [tableView dequeueReusableCellWithIdentifier:@"teamCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *teams = self.searchController.isActive ? self.searchResults : self.teams;
    BCTeam *team = teams[indexPath.row];
    
    teamCell.name.text = team.name;
    [teamCell.shield sd_setImageWithURL:(NSURL *)team.imageURL];

    return teamCell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToTeamDetail"]) {
        BCTeamDetailViewController *detailVC = segue.destinationViewController;
        BCTeam *team = self.teams[self.tableView.indexPathForSelectedRow.row];
        detailVC.team = team;
    }
}


#pragma mark - Search
- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
}

- (void)searchTeamsForText:(NSString *)text {
    self.searchResults = [self.teams bk_select:^BOOL(BCTeam *team) {
        return [team.name rangeOfString:text options:NSCaseInsensitiveSearch].location != NSNotFound;
    }];
    [self.tableView reloadData];
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
        // Set searchString equal to what's typed into the searchbar
        NSString *searchString = self.searchController.searchBar.text;
        
        [self searchTeamsForText:searchString];
    
        [self.tableView reloadData];
}

@end
