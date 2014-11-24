//
//  Classification.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "Classification.h"

@interface Classification()
@end

@implementation Classification

- (instancetype)initWithTitle:(NSString*) title andChildren:(NSArray *)children
{
    self = [super init];
    if (self) {
        self.title = title;
        
        NSMutableArray *childArray = [[NSMutableArray alloc] initWithCapacity:children.count];
        for (NSString* childString in children) {
            [childArray addObject:[[Classification alloc] initWithTitle:childString andChildren:nil]];
        }
        self.children = childArray;
    }
    return self;
}

@end
