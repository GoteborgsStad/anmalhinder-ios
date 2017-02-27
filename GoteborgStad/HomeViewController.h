//
//  HomeViewController.h
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AFHTTPRequestOperationManager.h"
#import "JSON.h"

@interface HomeViewController : UIViewController <UIAlertViewDelegate>
{
    AppDelegate *appdel;
    AFHTTPRequestOperationManager *AfManager;

    IBOutlet UIScrollView *formScroll;
    IBOutlet UILabel *stageLabel, *headerLabel;
    IBOutlet UIView *infoBgView;
    IBOutlet UIButton *skikaBtn;
    IBOutlet UIImageView *mapImageView, *photoImageView;
    IBOutlet UIImageView *icon1ImgView, *icon2ImgView, *icon3ImgView, *icon4ImgView;
    IBOutlet UILabel *anmalLabel, *locationLabel, *photoLabel, *contactLabel;
    IBOutlet UIButton *anmalBtn, *locationBtn, *photoBtn, *contactBtn;
    IBOutlet UIView *anmalBgView, *locationBgView, *photoBgView, *contactBgView;
    
    NSString *categoryStr, *descStr, *addressStr, *locationStr, *nameStr, *emailStr, *phoneStr;
}

@end
