//
//  AdoptingAnAnnotation.h
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface AdoptingAnAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly)  CLLocationCoordinate2D coordinate;
- (NSString *)title;
- (NSString *)subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
@end
