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
#import "FakeDemoViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UITextField *loginTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height + 60, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        CGRect frame = CGRectMake(self.activeField.frame.origin.x, self.activeField.frame.origin.y, self.activeField.frame.size.width, self.activeField.frame.size.height);
        [self.scrollView scrollRectToVisible:frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        DecorListViewController *vc = [segue destinationViewController];
        vc.back = NO;
    }
    else if ([[segue identifier] isEqualToString:@"toSections"])
    {
        FakeDemoViewController *vc = [segue destinationViewController];
        vc.type = 1;
    }
    else if ([[segue identifier] isEqualToString:@"toPro"])
    {
        [[Services shared] loginWithUserName:@"Logged" andPassword:@"NO" withHandler:^(BOOL success, NSError *error) {
        }];
    }
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.loginTF)
    {
        [self.passwordTF becomeFirstResponder];
    }
    if(textField == self.passwordTF)
    {
        [self loginWithByPass:NO];
    }
    return YES;
}
- (IBAction)buttonPressed:(id)sender {
    [self loginWithByPass:YES];
}

- (void) loginWithByPass:(BOOL) bypass
{
    NSString *userName = self.loginTF.text;
    NSString *password = self.passwordTF.text;
    
    if(bypass)
    {
        userName = @"Demo";
    }
    
    [[Services shared] loginWithUserName:userName andPassword:password withHandler:^(BOOL success, NSError *error) {
        //        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"Login result" message:[NSString stringWithFormat:@"Result : %i", result] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        //
        //        [alerview show];
        
        if(success == YES || bypass == YES)
        {
            [self performSegueWithIdentifier:@"toDecorList" sender:nil];
        }
        else
        {
            UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"Login" message:[NSString stringWithFormat:@"Erreur de connexion"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alerview show];
        }
    }];
}

@end
