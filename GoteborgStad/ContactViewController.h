//
//  ContactViewController.h
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ContactViewController : UIViewController <UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    AppDelegate *appdel;
    
    IBOutlet UIScrollView *formScroll;
    IBOutlet UILabel *stageLabel, *headerLabel;
    IBOutlet UIView *infoBgView;
    IBOutlet UIButton *nextBtn;
    IBOutlet UITextField *nameField, *emailField, *phoneField;
}
@end
