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

- (void) getPersoListWithHandler:(void (^)(NSArray* result, NSError *error)) completionBlock;

#pragma mark - Login/logoff
- (void) loginWithUserName:(NSString *) string andPassword:(NSString*) password withHandler:(void (^)(BOOL result, NSError *error))completionBlock;
- (void) logoff;

#pragma mark - Map
- (void)addLocationForThisPlace:(LieuDeTournage *)lieu location:(CLLocation *)location;

#pragma mark - Liking
- (void) likeThisPlace:(LieuDeTournage*) lieu;
- (BOOL) alreadyLikedThisPlace:(LieuDeTournage*) lieu;

#pragma mark - Classfification
- (void) classificateThisPlace:(LieuDeTournage*) lieu withThisClassification:(NSString*) classification;

#pragma mark - Owner
- (void) ownerThisPlace:(LieuDeTournage*) lieu;

#pragma mark - AlreadyUsed
- (void) alreadyUsedThisPlace:(LieuDeTournage*) lieu;
- (void) addExplicationForThisPlace:(LieuDeTournage*) lieu explication:(NSString*)explication;

#pragma mark - Listing

- (NSArray*) getClassifications;

@end
