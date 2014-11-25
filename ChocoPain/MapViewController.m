//
//  MapViewController.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "MapViewController.h"

#import "AdoptingAnAnnotation.h"
#import "Services.h"

#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Bonjour : %@", self.name);
    [self.mapView setDelegate:self];
    
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonL.frame = CGRectMake(0, 0, 16, 23);
    //button.backgroundColor = [UIColor redColor];
    [buttonL setImage:[UIImage imageNamed:@"BACKBUTTON.png"] forState:UIControlStateNormal];
    [buttonL setImage:[UIImage imageNamed:@"BACKBUTTONPush.png"] forState:UIControlStateHighlighted];
    [buttonL addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonL=[[UIBarButtonItem alloc] init];
    [barButtonL setCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=barButtonL;
    
    UIButton *fakeB = [UIButton buttonWithType:UIButtonTypeCustom];
    fakeB.frame = CGRectMake(0, 0, 16, 23);
    UIBarButtonItem *barButtonRF=[[UIBarButtonItem alloc] init];
    [barButtonRF setCustomView:fakeB];
    self.navigationItem.rightBarButtonItem=barButtonRF;
    
    //[self.navigationItem setTitle:@"Détail"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    //[view setBackgroundColor:[UIColor redColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    [label setFont:[UIFont fontWithName:@"Antonio-Regular" size:17.f]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"Localisation"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    
    [self.navigationItem setTitleView:view];
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5;
    [self.mapView addGestureRecognizer:lpgr];
    
    if(self.lieu.location!=nil)
    {
        CLLocationCoordinate2D touchMapCoordinate = self.lieu.location.coordinate;
        
        AdoptingAnAnnotation *annot = [[AdoptingAnAnnotation alloc] initWithCoordinate:touchMapCoordinate];
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView addAnnotation:annot];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (UIGestureRecognizer *recognizer in self.mapView.gestureRecognizers) {
        [self.mapView removeGestureRecognizer:recognizer];
    }
    
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    AdoptingAnAnnotation *annot = [[AdoptingAnAnnotation alloc] initWithCoordinate:touchMapCoordinate];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:annot];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    [[Services shared] addLocationForThisPlace:self.lieu location:location];
}

- (MKAnnotationView *) mapView:(MKMapView *) mapView viewForAnnotation:(id ) annotation {
    MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    customPinView.pinColor = MKPinAnnotationColorPurple;
    customPinView.animatesDrop = YES;
    customPinView.canShowCallout = NO;
    return customPinView;
}




//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    MKPinAnnotationView *pinView = nil;
//    
//    static NSString *defaultPinID = @"identifier";
//    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
//    if ( pinView == nil )
//    {
//        NSLog(@"Inside IF");
//        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
//        
//        pinView.pinColor = MKPinAnnotationColorRed;  //or Green or Purple
//        
//        pinView.enabled = YES;
//        pinView.canShowCallout = YES;
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        
//        //Accessoryview for the annotation view in ios.
//        pinView.rightCalloutAccessoryView = btn;
//    }
//    else
//    {
//        pinView.annotation = annotation;
//    }
//    
//    return pinView;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
