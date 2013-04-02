//
//  ViewController.m
//  CoreLocationPoC
//
//  Created by Mike Berlin on 3/24/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import "ViewController.h"
#import "Place.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [self.locationManager startUpdatingLocation];

    self.mapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    
    self.lblLatitude.text = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.latitude];
    self.lblLongitude.text = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.longitude];
    self.lblHorizontalAccuracy.text = [NSString stringWithFormat:@"%gm", newLocation.horizontalAccuracy];
    self.lblAltitude.text = [NSString stringWithFormat:@"%gm", newLocation.altitude];
    self.lblVerticalAccuracy.text = [NSString stringWithFormat:@"%gm", newLocation.verticalAccuracy];

    if (newLocation.verticalAccuracy < 0 || newLocation.horizontalAccuracy < 0)
    {
        // invalid accuracy
        return;
    }

    if (newLocation.horizontalAccuracy > 100 || newLocation.verticalAccuracy > 50)
    {
        // accuracy radius is so large, we don't want to use it
        return;
    }

    if (self.startPoint == Nil)
    {
        self.startPoint = newLocation;
        self.distanceFromStart = 0;
        
        Place *start = [[Place alloc] init];
        start.coordinate = newLocation.coordinate;
        start.title = @"Start Point";
        start.subTitle = @"This is where we started!";

        [self.mapView addAnnotation:start];
        self.mapView.centerCoordinate = start.coordinate;

        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100);
        [self.mapView setRegion:region animated:YES];
    }
    else
    {
        self.distanceFromStart = [newLocation distanceFromLocation:self.startPoint];
    }

    self.lblDistanceTraveled.text = [NSString stringWithFormat:@"%gm", self.distanceFromStart];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error getting location"
                          message:errorType
                          delegate:Nil
                          cancelButtonTitle:@"Okay"
                          otherButtonTitles:Nil, nil];

    [alert show];
}

@end