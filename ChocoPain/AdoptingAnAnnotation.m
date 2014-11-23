//
//  AdoptingAnAnnotation.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//


#import "AdoptingAnAnnotation.h"

@interface AdoptingAnAnnotation()

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (nonatomic, strong) NSString *adresse;


@end

@implementation AdoptingAnAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self.latitude = coordinate.latitude;
    self.longitude = coordinate.longitude;
    
    [self reverveGeocode];
    
    return self;
}
- (CLLocationCoordinate2D) coordinate {
    CLLocationCoordinate2D coord;
    coord.latitude = self.latitude;
    coord.longitude = self.longitude;
    return coord;
}

- (NSString *)title
{
    return @"Adresse";
}

- (NSString *)subtitle
{
    return self.adresse;
}

- (void) reverveGeocode
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location // You can pass aLocation here instead
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       dispatch_async(dispatch_get_main_queue(),^ {
                           // do stuff with placemarks on the main thread
                           
                           if (placemarks.count == 1) {
                               
                               CLPlacemark *place = [placemarks objectAtIndex:0];
                               
                              
                               
                               [self performSelectorInBackground:@selector(showWeatherFor:) withObject:place];
                               
                           }
                           
                       });
                       
                   }];
}

- (void) showWeatherFor:(CLPlacemark*) place
{
    NSString *cityString = [place.addressDictionary valueForKey:@"City"];
    NSString *stateString = [place.addressDictionary valueForKey:@"State"];
    self.adresse = [NSString stringWithFormat:@"%@ - %@", cityString, stateString];
}

@end
