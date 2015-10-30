//
//  BCWalkthroughContentViewController.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/30/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "BCWalkthroughContentViewController.h"

@interface BCWalkthroughContentViewController ()

@end

@implementation BCWalkthroughContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.closeButton.layer.borderWidth = 1;
    self.closeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.closeButton.layer.cornerRadius = self.closeButton.frame.size.height / 2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeView:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"true" forKey:@"already_displayed_walkthrough"];

    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
