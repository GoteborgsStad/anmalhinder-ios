//
//  PhotoViewController.m
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production.
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import "PhotoViewController.h"
#import "ContactViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_4_OR_LESS) {
        [formScroll setContentSize:CGSizeMake(320, 568)];
    }
    
    [stageLabel setTextColor:BtnBgColor];
    [headerLabel setTextColor:AppGreenColor];
    [infoBgView setBackgroundColor:AppGreenColor];
    [cameraBtn setBackgroundColor:BtnBgColor];
    [galleryBtn setBackgroundColor:BtnBgColor];
    [nextBtn setBackgroundColor:BtnBgColor];

}

-(IBAction)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)nextButtonTapped
{
    ContactViewController *contact = [[ContactViewController alloc] init];
    [self.navigationController pushViewController:contact animated:YES];
}


-(IBAction)photoButtonTapped:(UIButton *)sender
{
    UIImagePickerController *imagePickerControllerObj = [[UIImagePickerController alloc] init];
    [imagePickerControllerObj setDelegate:self];
    [imagePickerControllerObj setAllowsEditing:YES];

    
    if (sender.tag == 0) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            imagePickerControllerObj.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerControllerObj animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Source" message:@"Source type not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
    }
    else{
        
        imagePickerControllerObj.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerControllerObj animated:YES completion:nil];
    }
}




#pragma mark
#pragma mark UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedPhoto = [info objectForKey:UIImagePickerControllerEditedImage];
    [UIImageJPEGRepresentation(selectedPhoto, 0.8) writeToFile:ImageFilePath atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
