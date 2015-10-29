//
//  BCMapViewController.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/29/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "BCMapViewController.h"

@interface BCMapViewController ()
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@end

@implementation BCMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    [geocoder geocodeAddressString:@"Av. Paulista, 1578 - Bela Vista, São Paulo"
                 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                     CLPlacemark *placemark = [placemarks firstObject];
                     NSLog(@"%@", placemark);
                     if(placemarks.count > 0)
                     {
                         CLPlacemark *placemark = [placemarks objectAtIndex:0];
                         //self.outputLabel.text = placemark.location.description;
                         
                         [self setInMap:placemark.location.coordinate.latitude
                              longitude:placemark.location.coordinate.longitude];
                     }
                 }];
}

- (void)setInMap:(float) latitude longitude:(float) longitude {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = @"Resultado da Busca";
    annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self.mapView showAnnotations:@[annotation] animated:YES];
    [self.mapView selectAnnotation:annotation animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
