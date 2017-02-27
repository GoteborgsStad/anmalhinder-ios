//
//  HomeViewController.m
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import "HomeViewController.h"
#import "MBProgressHUD.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appdel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 568)];
    }
    
    
    categoryStr = @"";
    descStr = @"";
    addressStr = @"";
    locationStr = @"";
    nameStr = @"";
    emailStr =@"";
    phoneStr = @"";
    
    
    [stageLabel setTextColor:BtnBgColor];
    [headerLabel setTextColor:SplashBlueColor];
    
    [anmalBgView setBackgroundColor:AppBlueColor];
    [locationBgView setBackgroundColor:AppPurpleColor];
    [photoBgView setBackgroundColor:AppGreenColor];
    [contactBgView setBackgroundColor:AppRedColor];

    [skikaBtn setBackgroundColor:BtnBgColor];
    
    
    if ([appdel.userDefaultObject objectForKey:AnmalDataKey]) {
        
        NSMutableDictionary *anmalDataDict = [appdel.userDefaultObject objectForKey:AnmalDataKey];
        categoryStr = [anmalDataDict objectForKey:@"selected_cat"];
        
        [icon1ImgView setFrame:CGRectMake(61, 42, 24, 24)];
        [anmalLabel setText:categoryStr];
        [anmalBtn setTitle:categoryStr forState:UIControlStateNormal];
    }
    
    if ([appdel.userDefaultObject objectForKey:DescTextKey]) {
        descStr = [appdel.userDefaultObject objectForKey:DescTextKey];
    }
    
    
    if ([appdel.userDefaultObject objectForKey:LocationAddressKey]) {
        
        addressStr = [appdel.userDefaultObject objectForKey:LocationAddressKey];
        locationStr = [NSString stringWithFormat:@"%@,%@",[appdel.userDefaultObject objectForKey:LocationLatitudeKey],[appdel.userDefaultObject objectForKey:LocationLongitudeKey]];
        
        [icon2ImgView setFrame:CGRectMake(61, 42, 24, 24)];
        [locationLabel setHidden:YES];
        locationBgView.alpha = 0.5;
        
        [self performSelector:@selector(loadMapImage) withObject:nil afterDelay:0.005];

    }

    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ImageFilePath]) {

        [icon3ImgView setFrame:CGRectMake(61, 42, 24, 24)];
        [photoLabel setHidden:YES];
        photoBgView.alpha = 0.5;
        
        UIImage *img = [UIImage imageWithContentsOfFile:ImageFilePath];
        [photoImageView setImage:img];
    }

    
    if ([appdel.userDefaultObject objectForKey:ContactDataKey]) {
        
        NSMutableDictionary *contactDataDict = [appdel.userDefaultObject objectForKey:ContactDataKey];
        nameStr = [contactDataDict objectForKey:@"name"];
        emailStr = [contactDataDict objectForKey:@"email"];
        phoneStr = [contactDataDict objectForKey:@"phone"];

        [icon4ImgView setFrame:CGRectMake(61, 42, 24, 24)];
        [contactLabel setText:nameStr];
        [contactBtn setTitle:nameStr forState:UIControlStateNormal];
    }

}





-(IBAction)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)squareButtonTapped:(UIButton *)sender
{
    NSLog(@"sender : %ld",(long)sender.tag);
    
    if (sender.tag == 0) {//Anmal
        
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
    }
    else if (sender.tag == 1) {//Location
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:3] animated:YES];
    }
    else if (sender.tag == 2) {//Camera
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:4] animated:YES];
    }
    else{//Contact
        
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:5] animated:YES];
    }
    
}

-(IBAction)skikaButtonTapped
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performSelector:@selector(uploadDataToServer) withObject:nil afterDelay:0.005];
}



#pragma mark - WEB FUNCTIONS

-(void)uploadDataToServer
{
    
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:@"sendmail" forKey:@"action"];
    [postDict setObject:categoryStr forKey:@"category"];
    [postDict setObject:@"" forKey:@"subcategory"];
    [postDict setObject:descStr forKey:@"description"];
    [postDict setObject:addressStr forKey:@"address"];
    [postDict setObject:locationStr forKey:@"location"];
    [postDict setObject:nameStr forKey:@"name"];
    [postDict setObject:emailStr forKey:@"email"];
    [postDict setObject:phoneStr forKey:@"phone"];
    
    
        //idle time disable during uploading
        [UIApplication sharedApplication].idleTimerDisabled = YES;
        
        
        NSString *enc_string;
        enc_string = [postDict JSONFragment];
    
        NSString *urlString=[[NSString alloc] initWithFormat:@"%@request=%@",BASEURL,enc_string];
        urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        NSLog(@"\n\nurlString:%@",urlString);
        
        AfManager = [AFHTTPRequestOperationManager manager];
        
        AfManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        AfManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        [AfManager.requestSerializer setTimeoutInterval:600.0f];
        
        
        AFHTTPRequestOperation *_operation =[AfManager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                             {
                                                 NSError *error;
                                                 
                                                 if ([[NSFileManager defaultManager] fileExistsAtPath:ImageFilePath]) {
                                                     
                                                     [formData appendPartWithFileURL:[NSURL fileURLWithPath:ImageFilePath] name:@"image" error:&error];
                                                 }
                                                 
                                             } success:^(AFHTTPRequestOperation *operation, id responseObject)
                                             {
                                                 
                                                 [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                                                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                 
                                                 
                                                 NSString *str=[[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                                                 str=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                                 
                                                 
                                                 NSLog(@"\n\nuploading service response:%@",str);
                                                 
                                                 NSData *dataRecieved=[str dataUsingEncoding:NSUTF8StringEncoding];
                                                 
                                                 NSMutableString *stringIs=[[NSMutableString alloc] initWithData:dataRecieved encoding:NSUTF8StringEncoding];
                                                 
                                                 NSLog(@"\n\nstring is:%@",stringIs);
                                                 
                                                 NSMutableDictionary *responseDict = [stringIs JSONValue] ;
                                                 
                                                 NSLog(@"\n\nresponseDict:%@\n\n",responseDict);
                                                 
                                                 if([[responseDict objectForKey:@"response"] isEqualToString:@"success"])
                                                 {
                                                     
                                                     //Success
                                                     UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"" message:[responseDict objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                                     [alert show];
                                                     
                                                 }
                                                 else
                                                 {
                                                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                     [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                                                     
                                                     UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"" message:[responseDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                                     [alert show];
                                                     
                                                 }
                                                 
                                                 
                                                 
                                                 
                                             } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                             {
                                                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                 [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
                                                 
                                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                 
                                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                 [alert show];
                                                                                                
                                                 
                                             }];
        
        
        
        //check up progress on uploading
        [_operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                             long long totalBytesWritten,
                                             long long totalBytesExpectedToWrite)
         {
             float currentProg=(float)totalBytesWritten/totalBytesExpectedToWrite;
             
             if(currentProg==1.0)
                 [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         }];
}




#pragma mark - LOAD MAP IMAGE
-(void)loadMapImage
{
    float latitudeValue = [[appdel.userDefaultObject objectForKey:LocationLatitudeKey] floatValue];
    float longitudeValue = [[appdel.userDefaultObject objectForKey:LocationLongitudeKey] floatValue];
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@&sensor=true",latitudeValue,longitudeValue,@"zoom=17&size=360x360"];
    
    
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    
    [mapImageView setImage:image];
}


#pragma mark - REMOVE ALL DATA

-(void)removeAllUserDefaultKeys
{
    [appdel.userDefaultObject removeObjectForKey:AnmalDataKey];
    [appdel.userDefaultObject removeObjectForKey:DescTextKey];
    [appdel.userDefaultObject removeObjectForKey:LocationAddressKey];
    [appdel.userDefaultObject removeObjectForKey:LocationLatitudeKey];
    [appdel.userDefaultObject removeObjectForKey:LocationLongitudeKey];
    [appdel.userDefaultObject synchronize];
    
    [[NSFileManager defaultManager] removeItemAtPath:ImageFilePath error:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - AlertView DELEGATE
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self removeAllUserDefaultKeys];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
