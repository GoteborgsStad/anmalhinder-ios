//
//  ContactViewController.m
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import "ContactViewController.h"
#import "HomeViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appdel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 568)];
    }
    
    
    [stageLabel setTextColor:BtnBgColor];
    [headerLabel setTextColor:AppRedColor];
    [infoBgView setBackgroundColor:AppRedColor];
    [nextBtn setBackgroundColor:BtnBgColor];

    
    UIColor *color = [UIColor blackColor];
    UIFont *customFont = [UIFont fontWithName:@"Gotham Book" size:20.0];
    
    nameField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Namn"
                                    attributes:@{NSForegroundColorAttributeName: color,
                                                 NSFontAttributeName : customFont }];

    emailField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"E-postadress"
                                    attributes:@{NSForegroundColorAttributeName: color,
                                                 NSFontAttributeName : customFont }];

    phoneField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Telefonnummer"
                                    attributes:@{NSForegroundColorAttributeName: color,
                                                 NSFontAttributeName : customFont }];

    if ([appdel.userDefaultObject objectForKey:ContactDataKey]) {
       
        NSMutableDictionary *savedDataDict = [appdel.userDefaultObject objectForKey:ContactDataKey];
        
        [nameField setText:[savedDataDict objectForKey:@"name"]];
        [emailField setText:[savedDataDict objectForKey:@"email"]];
        [phoneField setText:[savedDataDict objectForKey:@"phone"]];
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [tap setDelegate:self];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    
    [self.view endEditing:YES];
}


-(IBAction)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)nextButtonTapped
{
    HomeViewController *home = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}


-(IBAction)sparaButtonTapped
{
    [self.view endEditing:YES];
    
}


-(void)updateContactLocalData
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:nameField.text forKey:@"name"];
    [dict setObject:emailField.text forKey:@"email"];
    [dict setObject:phoneField.text forKey:@"phone"];
    
    [appdel.userDefaultObject setObject:dict forKey:ContactDataKey];
    [appdel.userDefaultObject synchronize];
}



#pragma mark - UITEXTFIELD DELEGATES

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.view.frame.origin.y == 0) {
        int yValueAnimate = 100;
        
        CGRect viewFrame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-yValueAnimate, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [self.view setFrame:viewFrame];
                         }
                         completion:nil];
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    CGRect viewFrame=CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.view setFrame:viewFrame];
                     }
                     completion:nil];
    
    
    if (textField.text.length > 0) {
        [self updateContactLocalData];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
