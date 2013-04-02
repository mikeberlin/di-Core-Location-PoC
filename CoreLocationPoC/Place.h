//
//  Place.h
//  CoreLocationPoC
//
//  Created by Mike Berlin on 3/24/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Place : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end