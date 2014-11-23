//
//  Services.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "Services.h"
#import "Classification.h"

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

#pragma mark - Listing

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


- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
