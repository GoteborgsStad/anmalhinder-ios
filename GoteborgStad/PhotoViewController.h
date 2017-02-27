//
//  PhotoViewController.h
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PhotoViewController : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    IBOutlet UIScrollView *formScroll;
    IBOutlet UILabel *stageLabel, *headerLabel;
    IBOutlet UIView *infoBgView;
    IBOutlet UIButton *nextBtn, *cameraBtn, *galleryBtn;

}
@end
