//
//  LieuDeTournage.h
//  ChocoPain
//
//  Created by Hervé on 24/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LieuDeTournage : NSObject

@property (nonatomic) int numberId;
@property (nonatomic) CLLocation *location;
@property (nonatomic, strong) NSMutableArray* classifications;
@property (nonatomic, strong) NSString *commentaire;
@property (nonatomic) BOOL owner;
@property (nonatomic, strong) NSArray* imagesName;
@property (nonatomic, strong) NSString* user;
@property (nonatomic) BOOL alreadyUsed;
@property (nonatomic, strong) NSString *explicationUsed;
@property (nonatomic) int likes;

- (NSString*) mainClassification;
- (NSString*) mainImageName;


@property (nonatomic, strong) NSMutableArray* likers;

@end
