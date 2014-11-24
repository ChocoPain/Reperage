//
//  FakeDemoViewController.m
//  ChocoPain
//
//  Created by Hervé on 24/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "FakeDemoViewController.h"
#import "DecorListViewController.h"

@interface FakeDemoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@end

@implementation FakeDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonL.frame = CGRectMake(0, 0, 16, 23);
    //button.backgroundColor = [UIColor redColor];
    [buttonL setImage:[UIImage imageNamed:@"BACKBUTTON.png"] forState:UIControlStateNormal];
    [buttonL setImage:[UIImage imageNamed:@"BACKBUTTONPush.png"] forState:UIControlStateHighlighted];
    [buttonL addTarget:self action:@selector(actionLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonL=[[UIBarButtonItem alloc] init];
    [barButtonL setCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=barButtonL;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 12, 24);
    //button.backgroundColor = [UIColor redColor];
    //[button setImage:[UIImage imageNamed:@"buttonMap.png"] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:@"buttonMapPushed.png"] forState:UIControlStateHighlighted];
    //[button addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.rightBarButtonItem=barButton;
    
    
    if(self.type == 1) //Dashboard
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        //[view setBackgroundColor:[UIColor redColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [label setFont:[UIFont fontWithName:@"Antonio-Regular" size:17.f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"DASHBOARD"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:label];
        
        [self.navigationItem setTitleView:view];
    }
    
    if(self.type == 2)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        //[view setBackgroundColor:[UIColor redColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [label setFont:[UIFont fontWithName:@"Antonio-Regular" size:17.f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"MES PROJETS"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:label];
        
        [self.navigationItem setTitleView:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 90, 24);
        [button setTitle:@"Modifier" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionRight:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
        [barButton setCustomView:button];
        self.navigationItem.rightBarButtonItem=barButton;
    }
    
    if(self.type == 3) //demande
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        //[view setBackgroundColor:[UIColor redColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [label setFont:[UIFont fontWithName:@"Antonio-Regular" size:17.f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"DEMANDE"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:label];
        
        [self.navigationItem setTitleView:view];
        
        UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
        [barButton setTitle:@"Valider"];    
        [barButton setTintColor:[UIColor whiteColor]];
        self.navigationItem.rightBarButtonItem=barButton;
    }
    
    if(self.type == 4) //Rechercher
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        //[view setBackgroundColor:[UIColor redColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [label setFont:[UIFont fontWithName:@"Antonio-Regular" size:17.f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"RECHERCHE"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:label];
        
        [self.navigationItem setTitleView:view];
    }
}

- (void) actionLeft:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) actionRight:(id) sender
{
    if (self.type == 2) {
        [self.mainImage setImage:[UIImage imageNamed:@"PAGEPROJETMODIF.png"]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 90, 24);
        [button setTitle:@"OK" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionRightBack:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
        [barButton setCustomView:button];
        self.navigationItem.rightBarButtonItem=barButton;
    }
}

- (void) actionRightBack:(id) sender
{
    if (self.type == 2) {
        [self.mainImage setImage:[UIImage imageNamed:@"PAGEPROJET.png"]];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 90, 24);
        [button setTitle:@"Modifier" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(actionRight:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
        [barButton setCustomView:button];
        self.navigationItem.rightBarButtonItem=barButton;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"toActuality"])
    {
        DecorListViewController *vc = [segue destinationViewController];
        vc.editing = NO;
        vc.back = YES;
    }
    else if ([[segue identifier] isEqualToString:@"toMyProjects"])
    {
        FakeDemoViewController *vc = [segue destinationViewController];
        vc.type = 2;
    }
    else if ([[segue identifier] isEqualToString:@"toDemande"])
    {
        FakeDemoViewController *vc = [segue destinationViewController];
        vc.type = 3;
    }
    else if ([[segue identifier] isEqualToString:@"toRecherche"])
    {
        FakeDemoViewController *vc = [segue destinationViewController];
        vc.type = 4;
    }
    
    
}


@end
