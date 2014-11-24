//
//  DecorListViewController.m
//  ChocoPain
//
//  Created by Hervé on 23/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "DecorListViewController.h"
#import "Services.h"

@interface DecorListViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

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
    [buttonL addTarget:self action:@selector(addDecor:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonL=[[UIBarButtonItem alloc] init];
    [barButtonL setCustomView:buttonL];
    self.navigationItem.leftBarButtonItem=barButtonL;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 22, 22);
    //button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:@"buttonExit.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"buttonExitPushed.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"DecorTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    // Configure Cell
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
    [label setText:[NSString stringWithFormat:@"Row %i in Section %i", [indexPath row], [indexPath section]]];
    
    return cell;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
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
