//
//  Services.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "Services.h"

@implementation Services


+ (id)shared {
    static Services *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void) loginWithUserName:(NSString *)username andPassword:(NSString*)password withHandler:(void (^)(BOOL result,NSError *error))completionBlock
{
    if([username isEqualToString:@"username"] && [password isEqualToString:@"password"])
    {
        completionBlock(YES, nil);
    }
    else
    {
        completionBlock(NO, nil);
    }
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
