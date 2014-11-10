//
//  ViewController.h
//  test
//
//  Created by Jeremy Siao Him Fa on 10/11/2014.
//  Copyright (c) 2014 Ziomoxis. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface ViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

