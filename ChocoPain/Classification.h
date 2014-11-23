//
//  Classification.h
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Classification : NSObject

@property (nonatomic, strong) NSArray *children;

- (instancetype)initWithTitle:(NSString*) title andChildren:(NSArray*) children;

@end
