//
//  ViewController.m
//  Uber-Bean
//
//  Created by Cameron Mcleod on 2019-06-14.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) CLLocation *userLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationManager = [[CLLocationManager alloc] init];
    
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    _locationManager.desiredAccuracy  = kCLLocationAccuracyBest;
    
    [_locationManager startUpdatingLocation];
    
    _locationManager.distanceFilter = 10;
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"location manager did update locations %@", locations[0]);
    _userLocation = locations[0];
    MKCoordinateSpan userSpan = MKCoordinateSpanMake(0.06, 0.06);
    MKCoordinateRegion userRegion = MKCoordinateRegionMake(_userLocation.coordinate, userSpan);
    [_mapView setRegion:userRegion animated:YES];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"location manager did fail with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    NSLog(@"%d", status );
    
    if ((status == kCLAuthorizationStatusAuthorizedWhenInUse) || (status == kCLAuthorizationStatusAuthorizedAlways)) {
        
        [_locationManager requestLocation];
        
    }
    
}

@end
