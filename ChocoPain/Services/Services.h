//
//  Services.h
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Services : NSObject

+ (id)shared;

- (void) loginWithUserName:(NSString *) string andPassword:(NSString*) password withHandler:(void (^)(BOOL result, NSError *error))completionBlock;

@end
