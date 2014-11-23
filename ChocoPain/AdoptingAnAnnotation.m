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


@end

@implementation AdoptingAnAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self.latitude = coordinate.latitude;
    self.longitude = coordinate.longitude;
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
    return @"Titre";
}

- (NSString *)subtitle
{
    return @"subTitle";
}
@end
