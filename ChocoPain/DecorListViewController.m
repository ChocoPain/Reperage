//
//  DecorListViewController.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "DecorListViewController.h"
#import "Services.h"
#import "LieuDeTournage.h"
#import "DetailDecorViewController.h"

@interface DecorListViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray* liste;

@property (nonatomic) BOOL private;

@end

@implementation DecorListViewController

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
    
    [self initializing];
}

- (void) initializing
{
    if(self.back == NO)
    {
        UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonL.frame = CGRectMake(0, 0, 22, 22);
        //button.backgroundColor = [UIColor redColor];
        [buttonL setImage:[UIImage imageNamed:@"buttonExit.png"] forState:UIControlStateNormal];
        [buttonL setImage:[UIImage imageNamed:@"buttonExitPushed.png"] forState:UIControlStateHighlighted];
        [buttonL addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButtonL=[[UIBarButtonItem alloc] init];
        [barButtonL setCustomView:buttonL];
        self.navigationItem.leftBarButtonItem=barButtonL;
    }
    else
    {
        UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonL.frame = CGRectMake(0, 0, 16, 23);
        //button.backgroundColor = [UIColor redColor];
        [buttonL setImage:[UIImage imageNamed:@"BACKBUTTON.png"] forState:UIControlStateNormal];
        [buttonL setImage:[UIImage imageNamed:@"BACKBUTTONPUSH.png"] forState:UIControlStateHighlighted];
        [buttonL addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButtonL=[[UIBarButtonItem alloc] init];
        [barButtonL setCustomView:buttonL];
        self.navigationItem.leftBarButtonItem=barButtonL;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 12, 24);
    //button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:@"buttonMap.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"buttonMapPushed.png"] forState:UIControlStateHighlighted];
    //[button addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.rightBarButtonItem=barButton;
    
    UIButton *buttonP = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonP.frame = CGRectMake(0, 0, 20, 22);
    //button.backgroundColor = [UIColor redColor];
    [buttonP setImage:[UIImage imageNamed:@"buttonPerso.png"] forState:UIControlStateNormal];
    [buttonP setImage:[UIImage imageNamed:@"buttonPersoPushed.png"] forState:UIControlStateHighlighted];
    [buttonP addTarget:self action:@selector(myAccount:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonP=[[UIBarButtonItem alloc] init];
    [barButtonP setCustomView:buttonP];
    [self.navigationItem setRightBarButtonItems:@[barButtonP, barButton]];
    
    
    //[Services shared]
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    if(self.private)
    {
        UIButton *buttonE = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonE.frame = CGRectMake(0, 0, 20, 22);
        //button.backgroundColor = [UIColor redColor];
        [buttonE setImage:[UIImage imageNamed:@"+.png"] forState:UIControlStateNormal];
        [buttonE addTarget:self action:@selector(addDecor:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButtonE=[[UIBarButtonItem alloc] init];
        [barButtonE setCustomView:buttonE];
        [self.navigationItem setRightBarButtonItem:barButtonE];
        
        [[Services shared] getPersoListWithHandler:^(NSArray *result, NSError *error) {
            self.liste = result;
            [self.tableView reloadData];
        }];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        //[view setBackgroundColor:[UIColor redColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [label setFont:[UIFont fontWithName:@"Antonio-Regular" size:17.f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"MON COMPTE"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:label];
        
        [self.navigationItem setTitleView:view];
    }
    else
    {
        [[Services shared] getNewsWithHandler:^(NSArray *result, NSError *error) {
            self.liste = result;
            [self.tableView reloadData];
        }];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        //[view setBackgroundColor:[UIColor redColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        [label setFont:[UIFont fontWithName:@"Antonio-Regular" size:17.f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:@"ACTUALITÉ"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:label];
        
        [self.navigationItem setTitleView:view];
    }
}

- (void) exit:(id) sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Etes-vous sûr de vouloir vous déconnecter ?" delegate:self cancelButtonTitle:@"Annuler" destructiveButtonTitle:@"Oui" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (void) back:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addDecor:(id) sender
{
    [self performSegueWithIdentifier:@"toDetail" sender:sender];
}

- (void) myAccount:(id) sender
{
    [self refreshMode];
}

- (void) refreshMode
{
    self.back = YES;
    self.private = YES;
    [self initializing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.liste.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"DecorTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    LieuDeTournage *l1 = [self.liste objectAtIndex:indexPath.row];
    
    // Configure Cell
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
    [label setText:[l1.mainClassification uppercaseString]];

    UIImageView *mainImageView = (UIImageView *)[cell.contentView viewWithTag:3];
    [mainImageView setImage:[Services convertImageToGrayScale:[UIImage imageNamed:l1.mainImageName]]];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5;
    [mainImageView addGestureRecognizer:lpgr];
    
    UIButton *heart = (UIButton *)[cell.contentView viewWithTag:2];
    [heart addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [heart setTitle:[NSString stringWithFormat:@"%i",l1.likes] forState:UIControlStateNormal];
    
    if([[Services shared] alreadyLikedThisPlace:l1])
    {
        [heart setBackgroundImage:[UIImage imageNamed:@"buttonHeartRed.png"] forState:UIControlStateNormal];
    }
    else
    {
        [heart setBackgroundImage:[UIImage imageNamed:@"buttonHeartBlack.png"] forState:UIControlStateNormal];
    }
    
    if(l1.likes>9)
    {
        [heart setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    }

    
    return cell;
}

- (void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"Long press Ended");
    }
    else {
        UIImageView *imageVi = ((UIImageView*) sender);
        
        NSLog(@"Long press detected.");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetail" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toDetail"]) {
        //NSLog(@"row : %lu", ((NSIndexPath*) sender).row);
        
        DetailDecorViewController *vc = [segue destinationViewController];
        
        if([sender isKindOfClass:[NSIndexPath class]])
        {
            vc.lieu =[self.liste objectAtIndex:((NSIndexPath*) sender).row];
        }
        else
        {
            vc.lieu = [[LieuDeTournage alloc] init];
        }
            
        vc.editable = self.private;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
    else
    {
        [[Services shared] logoff];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) favoriteButtonPressed:(id)sender
{
    UITableViewCell *clickedCell =  (UITableViewCell*) [[sender superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:clickedCell];
    NSLog(@"Click : %lu", indexPath.row);
    
    LieuDeTournage *lieu = [self.liste objectAtIndex:indexPath.row];
    
    [[Services shared] likeThisPlace:lieu];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
