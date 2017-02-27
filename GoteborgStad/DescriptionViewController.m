//
//  DescriptionViewController.m
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production.
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import "DescriptionViewController.h"
#import "PhotoViewController.h"
#import "LocationPickerViewController.h"


@interface DescriptionViewController ()<LocationPickerDelegate>{
    LocationPickerViewController *picker;
    UIPlace *place;
}
@end


@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appdel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 568)];
    }

    [stageLabel setTextColor:BtnBgColor];
    [headerLabel setTextColor:AppBlueColor];
    [infoBgView setBackgroundColor:AppBlueColor];
    [nextBtn setBackgroundColor:BtnBgColor];
    
    if ([appdel.userDefaultObject objectForKey:DescTextKey]) {
        [descriptionTextView setText:[appdel.userDefaultObject objectForKey:DescTextKey]];
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
    if ([appdel.userDefaultObject objectForKey:LocationLatitudeKey]) {
        float latitudeValue = [[appdel.userDefaultObject objectForKey:LocationLatitudeKey] floatValue];
        float longitudeValue = [[appdel.userDefaultObject objectForKey:LocationLongitudeKey] floatValue];
        
        CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:latitudeValue longitude:longitudeValue];
        
        UIPlace *savedPlace = [[UIPlace alloc] init];
        [savedPlace setPlaceName:@""];
        [savedPlace setLocation:LocationAtual];
        [savedPlace setCompleteAddress:[appdel.userDefaultObject objectForKey:LocationAddressKey]];
        
        picker = [[LocationPickerViewController alloc] initWithUIPlace:savedPlace];
        picker.delegate = self;
        [self.navigationController pushViewController:picker animated:YES];
        
    }
    else{
        picker = [[LocationPickerViewController alloc] initWithUIPlace:nil];
        picker.delegate = self;
        
        [self.navigationController pushViewController:picker animated:YES];
    }
    
}


#pragma mark - PLACE PICKER FUNCTIONS

-(void)placePickerDidSelectPlace:(UIPlace *)__place{
    place = __place;
    
    [appdel.userDefaultObject setObject:place.completeAddress forKey:LocationAddressKey];
    [appdel.userDefaultObject setObject:[NSString stringWithFormat:@"%lf",place.location.coordinate.latitude] forKey:LocationLatitudeKey];
    [appdel.userDefaultObject setObject:[NSString stringWithFormat:@"%lf",place.location.coordinate.longitude] forKey:LocationLongitudeKey];
    [appdel.userDefaultObject synchronize];
    
    [self moveToPhotoController];
}

-(void)placePickerDidCancel{
    [self hidePlacePicker];
}

-(void)hidePlacePicker{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)moveToPhotoController
{
    PhotoViewController *photo = [[PhotoViewController alloc] init];
    [self.navigationController pushViewController:photo animated:YES];
}


#pragma mark - UITEXTVIEW DELEGATE

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 820)];
    }
    else{
        [formScroll setContentSize:CGSizeMake(320, 820)];
    }
    
    
    if ([textView.text isEqualToString:@"Beskriv hindret"]) {
        [textView setText:@""];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 568)];
    }
    else{
        [formScroll setContentSize:CGSizeZero];
    }
    
    if (textView.text.length == 0 || [textView.text isEqualToString:@" "]) {
        [textView setText:@"Beskriv hindret"];
    }
    
    if (![textView.text isEqualToString:@"Beskriv hindret"]) {
        [self updateLocalData];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}



-(void)updateLocalData
{
    NSString *descriptionText = @"";
    
    if (![descriptionTextView.text isEqualToString:@"Beskriv hindret"]) {
        descriptionText = descriptionTextView.text;
    }
    
    [appdel.userDefaultObject setObject:descriptionText forKey:DescTextKey];
    [appdel.userDefaultObject synchronize];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
