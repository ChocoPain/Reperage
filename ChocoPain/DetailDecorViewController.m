//
//  DetailDecorViewController.m
//  ChocoPain
//
//  Created by Hervé on 24/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "DetailDecorViewController.h"
#import "ClassificationsViewController.h"
#import "Services.h"

@interface DetailDecorViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (weak, nonatomic) IBOutlet UIButton *ownerButton;

@end

@implementation DetailDecorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
}

- (void) displayImages
{
    int count = 0;
    for (NSString *imageName in self.lieu.imagesName) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        
        [imageV setFrame:CGRectMake(10+count*150, 5, 120, 120)];
        
        
        [self.scrollView addSubview:imageV];
        count++;
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10+count*150, 5, 120, 120)];
    [button setImage:[UIImage imageNamed:@"PHOTOBUTTON.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];

    [self.scrollView addSubview:button];
    
    self.scrollView.contentSize = CGSizeMake(160 * (self.lieu.imagesName.count+1), 130);

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
    [self dismissViewControllerAnimated:YES completion:^{
        //
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
