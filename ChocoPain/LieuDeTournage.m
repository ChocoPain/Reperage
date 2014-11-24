//
//  LieuDeTournage.m
//  ChocoPain
//
//  Created by Hervé on 24/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "LieuDeTournage.h"

@implementation LieuDeTournage

- (NSString *)mainClassification
{
    return (self.classifications.count>0) ? [self.classifications objectAtIndex:0] : @"";
}

- (NSString *)mainImageName
{
    return (self.imagesName.count>0) ? [self.imagesName objectAtIndex:0] : @"";
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.likers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
