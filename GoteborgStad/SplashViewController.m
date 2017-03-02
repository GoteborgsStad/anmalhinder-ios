//
//  SplashViewController.m
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production.
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import "SplashViewController.h"
#import "AnmalHinderViewController.h"
#import "InfoViewController.h"


@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [anmalBgView setBackgroundColor:SplashBlueColor];
    [infoButton setBackgroundColor:BtnBgColor];
    
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 568)];
    }
}

-(IBAction)anmalButtonTapped
{
    AnmalHinderViewController *anmal = [[AnmalHinderViewController alloc] init];
    [self.navigationController pushViewController:anmal animated:YES];
}


-(IBAction)infoButtonTapped
{
    InfoViewController *info = [[InfoViewController alloc] init];
    [self.navigationController presentViewController:info animated:NO completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
