//
//  MapViewController.h
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LieuDeTournage.h"

@interface MapViewController : UIViewController

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) LieuDeTournage *lieu;


@end
