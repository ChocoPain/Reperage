//
//  Services.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "Services.h"
#import "Classification.h"
#import "User.h"

@interface Services()

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) NSArray *cacheListe;

@end

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
    self.user = [[User alloc] init];
    self.user.username = username;
    
    if([username isEqualToString:@"u"] && [password isEqualToString:@"p"])
    {
        completionBlock(YES, nil);
    }
    else
    {
        completionBlock(NO, nil);
    }
}

- ( void) logoff
{
    self.user = nil;
    self.cacheListe = nil;
}

- (void) likeThisPlace:(LieuDeTournage*) lieu
{
    for (LieuDeTournage *l in self.cacheListe) {
        if(l.numberId == lieu.numberId)
        {
            if ([l.likers containsObject:self.user.username]) {
                l.likes--;
                [l.likers removeObject:self.user.username];
            }
            else
            {
                l.likes++;
                [l.likers addObject:self.user.username];
            }
            
        }
    }
}

- (BOOL) alreadyLikeThisPlace:(LieuDeTournage*) lieu
{
    for (LieuDeTournage *l in self.cacheListe) {
        if(l.numberId == lieu.numberId)
        {
            if ([l.likers containsObject:self.user.username]) {
                return YES;
            }
            else
            {
                return NO;
            }
            
        }
    }
    return NO;
}

#pragma mark - Listing

- (void) getNewsWithHandler:(void (^)(NSArray* result, NSError *error)) completionBlock
{
    if(self.cacheListe==nil)
    {
        LieuDeTournage *l1 = [[LieuDeTournage alloc] init];
        l1.numberId = 1;
        l1.imagesName = [NSArray arrayWithObjects:@"naval1.jpeg", @"naval2.jpeg", @"naval4.jpeg", nil];
        l1.likes = 3;
        l1.classifications = [NSArray arrayWithObjects:@"Transport maritime/fluvial", nil];
        
        LieuDeTournage *l2 = [[LieuDeTournage alloc] init];
        l2.numberId = 2;
        l2.imagesName = [NSArray arrayWithObjects:@"naval3.jpeg", @"naval4.jpeg", nil];
        l2.likes = 1;
        l2.classifications = [NSArray arrayWithObjects:@"Appartement", nil];
        
        LieuDeTournage *l3 = [[LieuDeTournage alloc] init];
        l3.numberId = 3;
        l3.imagesName = [NSArray arrayWithObjects:@"naval4.jpeg", @"naval5.jpeg", nil];
        l3.likes = 0;
        l3.classifications = [NSArray arrayWithObjects:@"Case", nil];
        
        self.cacheListe = [NSArray arrayWithObjects:l1, l2, l3, nil];
        
    }
    completionBlock(self.cacheListe, nil);
}

- (NSArray *)getClassifications
{
    Classification *cla1 = [[Classification alloc] initWithTitle:@"Habitation/Logement" andChildren:[[NSArray alloc] initWithObjects:
    @"Appartement ",
    @"Building",
    @"Logement précaire ",
    @"Case",
    @"Chalet",
    @"Chateau/Manoirs",
    @"Ferme",
    @"Logement de vacance/Hotel/Gîte",
    @"Lotissement/Cité",
    @"Maison",
    @"Moulin",
    @"Villa",
                                                                                                     nil]];
    
    Classification *cla2 = [[Classification alloc] initWithTitle:@"Nature/Espace vert" andChildren:[[NSArray alloc] initWithObjects:

    @"Cascades/Gués/Fontaine/Sources",
    @"Collines/Terrils",
    @"Montagne",
    @"Cours d’eau",
    @"Dunes/sable/Plage",
    @"Falaise/Rochers",
    @"Forets/Bois",
    @"Parcs et Jardins",
    @"Plaines de jeux",
    @"Plan d’eau",
    @"Prairies/prés/champs",
    @"Souterrains/grottes",
    @"Terrains vagues",
                                                                                                    nil]];
    
    
    Classification *cla3 = [[Classification alloc] initWithTitle:@"Bâtiments et sites" andChildren:[[NSArray alloc] initWithObjects:

    @"Administratifs",
    @"Agricole",
    @"Artisanaux",
    @"Commerciaux/Financiers",
    @"Profession libérale",
    @"Culturels et folklorique",
    @"Enseignements et recherche",
    @"Equipement collectif",
    @"Funéraire",
    @"Monuments Historiques",
    @"Restaurant/Bar",
    @"Médicaux/Hospitalier/Sociaux",
    @"Industriels",
    @"Industriels/Carcéraux",
    @"Sites de loisirs",
    @"Militaires/Secours/Maintien de l’ordre",
    @"Parking/Stationnement",
    @"Religieux",
    @"Salles diverses",
    @"Sportifs", nil]];
    
    
    Classification *cla4 = [[Classification alloc] initWithTitle:@"Communication/Réseaux de transports" andChildren:[[NSArray alloc] initWithObjects:
    @"Autoroutes et aires",
    @"Avenues et Boulevards",
    @"Pistes cyclables",
    @"Ponts/Tunnels/Trémilles",
    @"Rues/Ruelles",
    @"Sentiers/Chemins/Voies pédestres",
    @"Transport aérien",
    @"Transport maritime/fluvial",
    @"Transport ferroviaire",
    @"Transports en commun/Transport Public", nil]];
    
    Classification *cla5 = [[Classification alloc] initWithTitle:@"Vues d’ensemble/Panorama" andChildren:[[NSArray alloc] initWithObjects:

    @"Paysages historiques",
    @"Paysages industriels",
    @"Paysages ruraux",
    @"Paysages urbains", nil]];
    
    
    return [NSArray arrayWithObjects:cla1, cla2, cla3, cla4, cla5, nil];
}


#pragma mark - Utility
+ (UIImage *)convertImageToGrayScale:(UIImage *)i
{
    int kRed = 1;
    int kGreen = 2;
    int kBlue = 4;
    
    int colors = kGreen | kBlue | kRed;
    int m_width = i.size.width;
    int m_height = i.size.height;
    
    uint32_t *rgbImage = (uint32_t *) malloc(m_width * m_height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImage, m_width, m_height, 8, m_width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, m_width, m_height), [i CGImage]);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // now convert to grayscale
    uint8_t *m_imageData = (uint8_t *) malloc(m_width * m_height);
    for(int y = 0; y < m_height; y++) {
        for(int x = 0; x < m_width; x++) {
            uint32_t rgbPixel=rgbImage[y*m_width+x];
            uint32_t sum=0,count=0;
            if (colors & kRed) {sum += (rgbPixel>>24)&255; count++;}
            if (colors & kGreen) {sum += (rgbPixel>>16)&255; count++;}
            if (colors & kBlue) {sum += (rgbPixel>>8)&255; count++;}
            m_imageData[y*m_width+x]=sum/count;
        }
    }
    free(rgbImage);
    
    // convert from a gray scale image back into a UIImage
    uint8_t *result = (uint8_t *) calloc(m_width * m_height *sizeof(uint32_t), 1);
    
    // process the image back to rgb
    for(int i = 0; i < m_height * m_width; i++) {
        result[i*4]=0;
        int val=m_imageData[i];
        result[i*4+1]=val;
        result[i*4+2]=val;
        result[i*4+3]=val;
    }
    
    // create a UIImage
    colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(result, m_width, m_height, 8, m_width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    
    free(m_imageData);
    
    // make sure the data will be released by giving it to an autoreleased NSData
    [NSData dataWithBytesNoCopy:result length:m_width * m_height];
    
    return resultUIImage;
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
