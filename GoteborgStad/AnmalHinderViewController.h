//
//  AnmalHinderViewController.h
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production.
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AnmalHinderViewController : UIViewController <UITextViewDelegate>
{
    AppDelegate *appdel;
    
    IBOutlet UIScrollView *formScroll;
    IBOutlet UITableView *categoryTable;

    IBOutlet UILabel *stageLabel, *headerLabel;
    IBOutlet UIView *infoBgView;
    IBOutlet UIButton *nextBtn;
    
    NSMutableArray *categoriesArray, *arrowImagesArray, *boolArray;
    NSMutableDictionary *savedDataDict;
    NSString *selectedAnmalTitle;
    int selectedSectionIndex, selectedRowIndex;
    BOOL isMainCatSelected, isSubCatSelected;
    BOOL isFromViewDidLoad, isScrolledToRow;
    
}
@end
