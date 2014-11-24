//
//  Services.h
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Services : NSObject

+ (id)shared;
+ (UIImage *)convertImageToGrayScale:(UIImage *)image;


- (void) loginWithUserName:(NSString *) string andPassword:(NSString*) password withHandler:(void (^)(BOOL result, NSError *error))completionBlock;


#pragma mark - Listing

- (NSArray*) getClassifications;

@end
