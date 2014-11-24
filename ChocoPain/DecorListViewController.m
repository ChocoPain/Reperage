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

@end

@implementation DecorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonL.frame = CGRectMake(0, 0, 22, 22);
    //button.backgroundColor = [UIColor redColor];
    [buttonL setImage:[UIImage imageNamed:@"buttonExit.png"] forState:UIControlStateNormal];
    [buttonL setImage:[UIImage imageNamed:@"buttonExitPushed.png"] forState:UIControlStateHighlighted];
    [buttonL addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonL=[[UIBarButtonItem alloc] init];
    [barButtonL setCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=barButtonL;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 12, 24);
    //button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:@"buttonMap.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"buttonMapPushed.png"] forState:UIControlStateHighlighted];
    //[button addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.rightBarButtonItem=barButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[Services shared]
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    [[Services shared] getNewsWithHandler:^(NSArray *result, NSError *error) {
        self.liste = result;
        [self.tableView reloadData];
    }];

}

- (void) exit:(id) sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Etes-vous sûr de vouloir vous déconnecter ?" delegate:self cancelButtonTitle:@"Annuler" destructiveButtonTitle:@"Oui" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (void) addDecor:(id) sender
{
    
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
    
    UIButton *heart = (UIButton *)[cell.contentView viewWithTag:2];
    [heart addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [heart setTitle:[NSString stringWithFormat:@"%i",l1.likes] forState:UIControlStateNormal];
    
    if([[Services shared] alreadyLikeThisPlace:l1])
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetail" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toDetail"]) {
        NSLog(@"row : %lu", ((NSIndexPath*) sender).row);
        
        DetailDecorViewController *vc = [segue destinationViewController];
        vc.lieu =[self.liste objectAtIndex:((NSIndexPath*) sender).row];
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
