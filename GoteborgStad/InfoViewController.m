//
//  InfoViewController.m
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production.
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [headerLabel setTextColor:BtnBgColor];
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 568)];
    }
    
    [self performSelector:@selector(setAttributedText) withObject:nil afterDelay:0.005];

}

-(void)setAttributedText
{
    NSString *linkStr = @"•	Läs mer om definitionen av enkelt avhjälpta hinder.";

    NSMutableAttributedString *normalStateText = [[NSMutableAttributedString alloc] initWithString:linkStr];
    [normalStateText addAttribute:NSUnderlineStyleAttributeName
                            value:@1
                            range:NSMakeRange(2, [normalStateText length]-2)];
    [normalStateText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [normalStateText length])];
    [normalStateText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, [normalStateText length])];
    [linkBtn setAttributedTitle:normalStateText forState:UIControlStateNormal];
    
    
    NSMutableAttributedString *highlightedStateText = [[NSMutableAttributedString alloc] initWithString:linkStr];
    [highlightedStateText addAttribute:NSUnderlineStyleAttributeName
                                  value:@1
                                  range:NSMakeRange(2, [highlightedStateText length]-2)];
    [highlightedStateText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, [highlightedStateText length])];
    
    [highlightedStateText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, [highlightedStateText length])];
    [linkBtn setAttributedTitle:highlightedStateText forState:UIControlStateHighlighted];

}


-(IBAction)backButtonTapped
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(IBAction)linkButtonTapped
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.boverket.se/sv/byggande/tillganglighet--bostadsutformning/tillganglighet/enkelt-avhjalpta-hinder/"]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
