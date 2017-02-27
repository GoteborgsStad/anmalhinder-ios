//
//  DescriptionViewController.h
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production.
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DescriptionViewController : UIViewController <UIGestureRecognizerDelegate>
{
    AppDelegate *appdel;
        
    IBOutlet UILabel *stageLabel, *headerLabel;
    IBOutlet UIView *infoBgView;
    IBOutlet UIButton *nextBtn;
    IBOutlet UITextView *descriptionTextView;
    IBOutlet UIScrollView *formScroll;
}
@end
