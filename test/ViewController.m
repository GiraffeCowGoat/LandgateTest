//
//  ViewController.m
//  test
//
//  Created by Jeremy Siao Him Fa on 10/11/2014.
//  Copyright (c) 2014 Ziomoxis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSArray *coordArray = [[NSArray alloc] initWithArray:[self getJsonData]];
    
    for (NSArray *coord in coordArray) {
        CLLocationCoordinate2D poi = CLLocationCoordinate2DMake([coord[1] floatValue], [coord[0] floatValue]);
        [self generateOverlay:poi];
    }
    
    NSLog(@"Lat: %f", [coordArray[0][1] floatValue]);
    NSLog(@"Long: %f", [coordArray[0][0] floatValue]);
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([coordArray[0][1] floatValue], [coordArray[0][0] floatValue]) animated:YES];
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([coordArray[0][1] floatValue], [coordArray[0][0] floatValue]);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(coor, span);
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*)getJsonData {
    NSArray *dataArray = nil;
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://www2.landgate.wa.gov.au/ows/wfspublic_4283/wfs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&typeName=slip:DAA-001&maxFeatures=1&outputFormat=json"]];
    NSError *error;
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    else {
        NSArray *featureCollection = dict[@"features"];
        NSDictionary *feature = featureCollection[0];
        NSDictionary *geometry = feature[@"geometry"];
        NSArray *coordinates = geometry[@"coordinates"];
        
        dataArray = coordinates[0][0];
    }
    
    return dataArray;
}

- (void)generateOverlay:(CLLocationCoordinate2D)coord {
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coord radius:5];
    [self.mapView addOverlay:circle];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    circleRenderer.strokeColor = [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:1.0] colorWithAlphaComponent:1];
    circleRenderer.lineWidth = 0.5;
    
    return circleRenderer;
}

@end
