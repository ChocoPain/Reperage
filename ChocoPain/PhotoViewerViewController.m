//
//  PhotoViewerViewController.m
//  ChocoPain
//
//  Created by Hervé on 25/11/14.
//  Copyright (c) 2014 Hervé. All rights reserved.
//

#import "PhotoViewerViewController.h"

@interface PhotoViewerViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PhotoViewerViewController

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
    [label setText:@"VISUALISATION"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
    
    [self.navigationItem setTitleView:view];

}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView setScalesPageToFit:YES];
    
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name='viewport' content='initial-scale = 1.0,maximum-scale = 0.3'/><style>body{margin:0;background-color:#000000}img{position:absolute;margin:auto;top:0;left:0;right:0;bottom:0;}</style></head><body><img src=\"%@\"></body></html>", self.imageName];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
