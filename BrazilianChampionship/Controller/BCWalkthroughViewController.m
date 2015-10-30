//
//  BCWalkthroughViewController.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/30/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "BCWalkthroughViewController.h"

@interface BCWalkthroughViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *screenInfo;

@end

@implementation BCWalkthroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialValues];
    
    [self setViewControllers:@[[self viewControllerAtIndex:0]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}

- (void)setupInitialValues {
    self.screenInfo = @[
                        @{@"title": @"Acompanhe todos os clubes candidatos ao título do Campeonato Brasileiro 2015", @"image": @"logo"},
                        @{@"title": @"Acompanhe todos os jogos do campeonato", @"image": @"matches"}
                        ];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
}


- (UIViewController *)viewControllerAtIndex:(NSInteger) index {
    if (index == NSNotFound || index >= self.screenInfo.count || index < 0) {
        return nil;
    }
    
    BCWalkthroughContentViewController *contentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"walkViewController"];
    
    [contentVC view];
    
    contentVC.index = index;
    contentVC.text.text = self.screenInfo[index][@"title"];
    contentVC.image.image = [UIImage imageNamed:self.screenInfo[index][@"image"]];
    contentVC.closeButton.hidden = index < (self.screenInfo.count -1);
    
    return contentVC;
}

#pragma mark - U8IPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((BCWalkthroughContentViewController *) viewController).index;
    
    index++;

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((BCWalkthroughContentViewController *) viewController).index;
    
    index--;
    
    return [self viewControllerAtIndex:index];
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
