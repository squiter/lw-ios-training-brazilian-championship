//
//  BCMatchTableViewCell.h
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCMatchTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *mDate;
@property (nonatomic, weak) IBOutlet UILabel *location;
@property (nonatomic, weak) IBOutlet UILabel *homeTeamName;
@property (nonatomic, weak) IBOutlet UILabel *homeTeamScore;
@property (nonatomic, weak) IBOutlet UILabel *vistitorTeamName;
@property (nonatomic, weak) IBOutlet UILabel *visitorTeamScore;
@property (nonatomic, weak) IBOutlet UIImageView *homeTeamSheild;
@property (nonatomic, weak) IBOutlet UIImageView *visitorTeamSheild;

@end
