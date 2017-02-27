//
//  AppDelegate.h
//  GoteborgStad
//
//  Created by Göteborgs Stad & Aveny Production.
//  Copyright © 2017 Göteborgs Stad & Aveny Production. All rights reserved.
//

#import <UIKit/UIKit.h>


#define BASEURL @"http://www.avenyproduction.se/www/anmalhinder-app/services/webservices.php?"

#define GothamBold      @"GothamBold"
#define GothamBook      @"GothamBook"
#define BotahmMedium    @"GothamMedium"


#define AnmalDataKey @"anmal_data"
#define DescTextKey @"desc_text"
#define LocationAddressKey @"location_address"
#define LocationLatitudeKey @"location_latitude"
#define LocationLongitudeKey @"location_longitude"
#define ContactDataKey @"contact_data"

#define DocFolder           [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define ImageFilePath   [[NSString alloc] initWithString:[DocFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"image.png"]]]


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)



#define SplashBlueColor [UIColor colorWithRed:(0.0)/255.0   green:(118.0)/255.0   blue:(188.0)/255.0    alpha:(1.0)]
#define AppBlueColor [UIColor colorWithRed:(7.0)/255.0   green:(73.0)/255.0   blue:(167.0)/255.0    alpha:(1.0)]
#define AppPurpleColor [UIColor colorWithRed:(77.0)/255.0   green:(84.0)/255.0   blue:(143.0)/255.0    alpha:(1.0)]
#define AppGreenColor [UIColor colorWithRed:(32.0)/255.0   green:(97.0)/255.0   blue:(69.0)/255.0    alpha:(1.0)]
#define AppRedColor [UIColor colorWithRed:(181.0)/255.0   green:(0.0)/255.0   blue:(0.0)/255.0    alpha:(1.0)]
#define BtnBgColor [UIColor colorWithRed:(56.0)/255.0   green:(76.0)/255.0   blue:(89.0)/255.0    alpha:(1.0)]


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSUserDefaults *userDefaultObject;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSUserDefaults *userDefaultObject;


@end

