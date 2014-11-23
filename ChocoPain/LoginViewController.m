//
//  ViewController.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "LoginViewController.h"

#import "Services.h"

#import "MapViewController.h"
#import "DecorListViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClicked:(id)sender {
    
    NSString *userName = @"username";
    NSString *password = @"password";
    
    [[Services shared] loginWithUserName:userName andPassword:password withHandler:^(BOOL success, NSError *error) {
//        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"Login result" message:[NSString stringWithFormat:@"Result : %i", result] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
//        
//        [alerview show];
        
        if(success == YES)
        {
            [self performSegueWithIdentifier:@"toDecorList" sender:sender];
        }
        else
        {
            UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"Login" message:[NSString stringWithFormat:@"Erreur de connexion"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alerview show];
        }
    }];
    
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"toMap"]) {
//        MapViewController *vc = [segue destinationViewController];
//        
//        // Pass the information to your destination view
//        [vc setName:@"Salomé..."];
//    }
//    else
        if ([[segue identifier] isEqualToString:@"toDecorList"]) {
        
        // Get destination view
        //DecorListViewController *vc = [segue destinationViewController];
        
    }
}

@end
