//
//  LocationPickerViewController.h
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"


@interface UIPlace : NSObject
@property(nonatomic,retain) NSString *placeName;
@property(nonatomic,retain) CLLocation *location;
@property(nonatomic,retain) NSString *completeAddress;
@end



@interface UIPlacePickerAnnotation : NSObject<MKAnnotation>

@property (nonatomic,retain) NSString *myTitle;
@property (nonatomic,retain) NSString *mySubtitle;
@property (nonatomic,retain) UIPlace *place;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c;

-(void)setTitle:(NSString *)title;
-(void)setSubtitle:(NSString *)subtitle;

@end



@protocol LocationPickerDelegate;

@interface LocationPickerViewController : UIViewController <CLLocationManagerDelegate> {
    
    IBOutlet UILabel *stageLabel, *headerLabel;
    IBOutlet UIView *infoBgView;
    IBOutlet UIButton *nextBtn;
    
    IBOutlet UIScrollView *formScroll;
    
    CLLocationManager *locationManager;
    CLLocationCoordinate2D LatNLon;
    
    IBOutlet MKMapView *mapMkView;
    IBOutlet UITextField *textField;
}

@property(nonatomic,retain) CLLocation *myLocation;
@property (nonatomic, assign) id <LocationPickerDelegate> delegate;
@property(nonatomic,retain) UIPlace *place;

-(void)acceptLocation;
-(IBAction)showPlaceNameAlert:(id)sender;
-(IBAction)cancel:(id)sender;
- (id)initWithUIPlace:(UIPlace*)place;
- (id)initWithUIPlaceOnlyVisitor:(UIPlace*)place;

@end

@protocol LocationPickerDelegate
- (void)placePickerDidSelectPlace:(UIPlace *)place;
- (void)placePickerDidCancel;
@end

