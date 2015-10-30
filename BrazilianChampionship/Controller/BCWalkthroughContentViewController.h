//
//  BCWalkthroughContentViewController.h
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/30/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BCWalkthroughContentViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *text;
@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;
@property (nonatomic) NSInteger index;

@end
