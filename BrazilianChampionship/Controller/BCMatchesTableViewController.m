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
    return 38;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%ld˚ Rodada", section + 1];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *titles = [NSMutableArray array];
    for (NSInteger i = 0; i < 38; i++) {
        [titles addObject:[NSString stringWithFormat:@"%ld", i]];
    }
    return titles;
}

- (NSInteger)getTeamIndexBy:(NSIndexPath *)indexPath {
    return indexPath.row + (10 * indexPath.section);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BCMatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"matchCell" forIndexPath:indexPath];
    
    BCMatch *match = self.matches[[self getTeamIndexBy:indexPath]];
    
    // Configure the cell...
    cell.mDate.text = match.formattedDate;
    cell.location.text = match.location;
    cell.homeTeamName.text = match.homeTeam.name;
    cell.homeTeamScore.text = match.homeTeamScore.stringValue;
    [cell.homeTeamSheild sd_setImageWithURL:(NSURL *) match.homeTeam.imageURL];
    cell.vistitorTeamName.text = match.visitorTeam.name;
    cell.visitorTeamScore.text = match.visitorTeamScore.stringValue;
    [cell.visitorTeamSheild sd_setImageWithURL:(NSURL *) match.visitorTeam.imageURL];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    BCMatch *current = self.matches[[self getTeamIndexBy:indexPath]];
    BOOL isAlreadyPassed = [current.mDate compare:NSDate.date] == NSOrderedDescending;
    NSString *locationMessage = isAlreadyPassed ?  @"Onde vai ser?" : @"Onde foi?";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"O que vc quer?"
                                                                             message:@"Quer ver onde é o role ou ser notificado do jogo?"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *goToLocation = [UIAlertAction actionWithTitle:locationMessage style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"goToLocation" sender:nil];
    }];
    UIAlertAction *setNotification = [UIAlertAction actionWithTitle:@"Me avise!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (isAlreadyPassed) {
            NSLog(@"match date > today");
            [self setNotificationFor:current];
        }else{
            NSLog(@"match date < today");
            [self matchPassedAway];
        }
    }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:goToLocation];
    [alertController addAction:setNotification];
    [alertController addAction:cancelButton];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)setNotificationFor:(BCMatch *)match {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = match.mDate;
    localNotification.alertTitle = @"Começo de jogo";
    localNotification.alertBody = [NSString stringWithFormat:@"O jogo %@ contra %@ já vai começar!", match.homeTeam.name, match.visitorTeam.name];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)matchPassedAway {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Aviso"
                                                                             message:@"Essa partida já passou principe. :("
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okButton];
    [self presentViewController:alertController animated:YES completion:nil];
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
