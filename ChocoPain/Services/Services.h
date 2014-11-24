//
//  Services.h
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LieuDeTournage.h"



@interface Services : NSObject

+ (id)shared;
+ (UIImage *)convertImageToGrayScale:(UIImage *)image;

#pragma mark - News
- (void) getNewsWithHandler:(void (^)(NSArray* result, NSError *error)) completionBlock;

#pragma mark - Login/logoff
- (void) loginWithUserName:(NSString *) string andPassword:(NSString*) password withHandler:(void (^)(BOOL result, NSError *error))completionBlock;
- (void) logoff;

#pragma mark - Liking
- (void) likeThisPlace:(LieuDeTournage*) lieu;
- (BOOL) alreadyLikeThisPlace:(LieuDeTournage*) lieu;


#pragma mark - Listing

- (NSArray*) getClassifications;

@end
