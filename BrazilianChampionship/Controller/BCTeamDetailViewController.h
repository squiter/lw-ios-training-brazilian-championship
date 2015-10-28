//
//  BCTeamDetailViewController.h
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTeam.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface BCTeamDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UIImageView *shield;

@property (nonatomic, strong) BCTeam *team;

@end
