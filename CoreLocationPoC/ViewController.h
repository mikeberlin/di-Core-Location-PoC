//
//  ViewController.h
//  CoreLocationPoC
//
//  Created by Mike Berlin on 3/24/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *startPoint;
@property (assign, nonatomic) CLLocationDistance distanceFromStart;

@property (weak, nonatomic) IBOutlet UILabel *lblLatitude;
@property (weak, nonatomic) IBOutlet UILabel *lblLongitude;
@property (weak, nonatomic) IBOutlet UILabel *lblHorizontalAccuracy;
@property (weak, nonatomic) IBOutlet UILabel *lblAltitude;
@property (weak, nonatomic) IBOutlet UILabel *lblVerticalAccuracy;
@property (weak, nonatomic) IBOutlet UILabel *lblDistanceTraveled;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end