//
//  DetailDecorViewController.h
//  ChocoPain
//
//  Created by Hervé on 24/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LieuDeTournage.h"

@interface DetailDecorViewController : UIViewController

@property (nonatomic) BOOL editable;

@property (nonatomic, strong) LieuDeTournage *lieu;

@end
