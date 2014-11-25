//
//  DetailDecorViewController.m
//  ChocoPain
//
//  Created by Hervé on 24/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "DetailDecorViewController.h"
#import "ClassificationsViewController.h"
#import "MapViewController.h"
#import "Services.h"

#import <Twitter/Twitter.h>

@interface DetailDecorViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (weak, nonatomic) IBOutlet UIButton *ownerButton;
@property (weak, nonatomic) IBOutlet UIButton *alreadyUsedButton;
@property (weak, nonatomic) IBOutlet UITextField *explication;

@property (weak, nonatomic) UITextField *activeField;

@property (weak, nonatomic) IBOutlet UITextField *explicationTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation DetailDecorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonL.frame = CGRectMake(0, 0, 16, 23);
    //button.backgroundColor = [UIColor redColor];
    [buttonL setImage:[UIImage imageNamed:@"BACKBUTTON.png"] forState:UIControlStateNormal];
    [buttonL setImage:[UIImage imageNamed:@"BACKBUTTONPush.png"] forState:UIControlStateHighlighted];
    [buttonL addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonL=[[UIBarButtonItem alloc] init];
    [barButtonL setCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=barButtonL;
    
    UIButton *fakeB = [UIButton buttonWithType:UIButtonTypeCustom];
    fakeB.frame = CGRectMake(0, 0, 16, 23);
    UIBarButtonItem *barButtonRF=[[UIBarButtonItem alloc] init];
    [barButtonRF setCustomView:fakeB];
    self.navigationItem.rightBarButtonItem=barButtonRF;
    
    //[self.navigationItem setTitle:@"Détail"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    //[view setBackgroundColor:[UIColor redColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    [label setFont:[UIFont fontWithName:@"Antonio-Regular" size:17.f]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"DÉTAIL"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    
    [self.navigationItem setTitleView:view];
    
    
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsEditing = YES;
    self.imgPicker.delegate = self;
    
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self initialized];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[Services shared] addExplicationForThisPlace:self.lieu explication:self.explication.text];
}

- (void) initialized
{
    [self displayImages];
    
    if(self.lieu.owner)
    {
        [self.ownerButton setImage:[UIImage imageNamed:@"OKBUTTON"] forState:UIControlStateNormal];
    }
    else
    {
        [self.ownerButton setImage:[UIImage imageNamed:@"OKBUTTONSANS"] forState:UIControlStateNormal];
    }
    
    if(self.lieu.alreadyUsed)
    {
        [self.alreadyUsedButton setImage:[UIImage imageNamed:@"OKBUTTON"] forState:UIControlStateNormal];
    }
    else
    {
        [self.alreadyUsedButton setImage:[UIImage imageNamed:@"OKBUTTONSANS"] forState:UIControlStateNormal];
    }
    
    [self.explication setText:self.lieu.explicationUsed];
    
}

- (void) displayImages
{
    for (UIView *child in self.scrollView.subviews) {
        [child removeFromSuperview];
    }
    
    int count = 0;

    if(self.editable)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20+count*130, 5, 120, 120)];
        [button setImage:[UIImage imageNamed:@"PHOTOBUTTON.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
        count++;
    }
    
    for (NSString *imageName in self.lieu.imagesName) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        
        [imageV setFrame:CGRectMake(20+count*130, 5, 120, 120)];
        [self.scrollView addSubview:imageV];
        count++;
    }
    count--;
    
    self.scrollView.contentSize = CGSizeMake(135 * (self.lieu.imagesName.count+((self.editable)?1:0)), 130);

}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height + 60, 0.0);
    self.mainScrollView.contentInset = contentInsets;
    self.mainScrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        CGRect frame = CGRectMake(self.activeField.frame.origin.x, self.activeField.frame.origin.y, self.activeField.frame.size.width, self.activeField.frame.size.height);
        [self.mainScrollView scrollRectToVisible:frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mainScrollView.contentInset = contentInsets;
    self.mainScrollView.scrollIndicatorInsets = contentInsets;
}

- (void) addPhoto:(id) sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selectionner l'image source" delegate:self cancelButtonTitle:@"Annuler" destructiveButtonTitle:nil otherButtonTitles:@"Appariel photo", @"Photothèque", nil];
        actionSheet.tag = 1;
        [actionSheet showInView:self.view];
    }
    else
    {
        self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imgPicker animated:YES completion:^{
            //
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toClassification"]) {
        ClassificationsViewController *vc = [segue destinationViewController];
        vc.lieu = self.lieu;
    }
    else if ([[segue identifier] isEqualToString:@"toMap"]) {
        MapViewController *vc = [segue destinationViewController];
        vc.lieu = self.lieu;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imgPicker animated:YES completion:^{
            //
        }];
    }
    else
    {
        self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imgPicker animated:YES completion:^{
            //
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    //image.image = img;
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // If you go to the folder below, you will find those pictures
    NSLog(@"%@",docDir);
    
    NSLog(@"saving png");
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/test.png",docDir];
    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(img)];
    [data1 writeToFile:pngFilePath atomically:YES];
    
    NSLog(@"saving image done");
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        //
        [self displayImages];
    }];
}
- (IBAction)ownerButtonClicked:(id)sender {
    
    [[Services shared] ownerThisPlace:self.lieu];
    
    if(self.lieu.owner)
    {
        [self.ownerButton setImage:[UIImage imageNamed:@"OKBUTTON"] forState:UIControlStateNormal];
    }
    else
    {
        [self.ownerButton setImage:[UIImage imageNamed:@"OKBUTTONSANS"] forState:UIControlStateNormal];
    }
}
- (IBAction)alreadyUsedClicked:(id)sender {
    
    [[Services shared] alreadyUsedThisPlace:self.lieu];
    
    if(self.lieu.alreadyUsed)
    {
        [self.alreadyUsedButton setImage:[UIImage imageNamed:@"OKBUTTON"] forState:UIControlStateNormal];
    }
    else
    {
        [self.alreadyUsedButton setImage:[UIImage imageNamed:@"OKBUTTONSANS"] forState:UIControlStateNormal];
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
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)twitterPressed:(id)sender {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            } else
                
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Regarde cette magnifique photo..."];
        
        //Adding the URL to the facebook post value from iOS
        
        [controller addURL:[NSURL URLWithString:@"http://www.reperage.org"]];
        
        //Adding the Image to the facebook post value from iOS
        
        [controller addImage:[UIImage imageNamed:self.lieu.mainImageName]];
        
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
