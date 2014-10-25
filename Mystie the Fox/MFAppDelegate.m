//
//  MFAppDelegate.m
//  Mystie the Fox
//
//  Created by Roman on 20.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFAppDelegate.h"
#import "MFSounds.h"
#import "MFAdColony.h"

#ifdef MystieFree
#import "TSTapstream.h"
#import <Chartboost/Chartboost.h>
#import <MobileAppTracker/MobileAppTracker.h>
#import <AdSupport/AdSupport.h>
#import <Parse/Parse.h>
#else
#import <floopsdk/floopsdk.h>
#endif

#import "MKStoreManager.h"
#import "GAI.h"

NSString *const bookAppID = @"899196882";
NSString *const TAP_STREAM_KEY = @"c_9ek3--RY-PeLND6eR4_Q";

@implementation MFAppDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
#ifdef MystieFree
    [MobileAppTracker applicationDidOpenURL:[url absoluteString] sourceApplication:sourceApplication];
#endif
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self frameworksSettings];
    
    [self.window makeKeyAndVisible];
    [[MFAdColony sharedAdColony] logEvent:EVENT_MAIN_APP_STARTED];
    self.splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
    self.splashView.image = [UIImage imageNamed:@"Default.png"];
    [_window addSubview:self.splashView];
    [_window bringSubviewToFront:self.splashView];
    //Set your animation below
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:10];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_window cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector (startupAnimationDone:finished:context:)];
    self.splashView.frame = CGRectMake(-60, -60, 440, 600);
    self.splashView.alpha = 0.0;
    [UIView commitAnimations];
#ifdef MystieFree
    TSConfig *config = [TSConfig configWithDefaults];
    [TSTapstream createWithAccountName:@"neoniks" developerSecret:TAP_STREAM_KEY config:config];
    [Parse setApplicationId:@"cVuYrhjOAgaAS1s2JE2XfOReatVA1vjF5rXH9TOQ"
                  clientKey:@"SLMLhk9PkZPGKToGKKIG3pjbO5QyFSjb2HpaaU8a"];
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
#else
    [[FloopSdkManager sharedInstance] startWithAppKey:@"17ef2aad77f1d417bb500d4469eb4bd6"];

#endif
    
    
    // Override point for customization after application launch.
    return YES;
}


#ifdef MystieFree
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}
#endif
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
#ifdef MystieFree
    [Chartboost cacheMoreApps:CBLocationHomeScreen];
    [MobileAppTracker measureSession];
#endif
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Custom Methods

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    [self.splashView removeFromSuperview];
}

#ifdef MystieFree

- ( void ) onAdColonyV4VCReward:(BOOL)success currencyName:(NSString*)currencyName currencyAmount:(int)amount inZone:(NSString*)zoneID {
	NSLog(@"AdColony zone %@ reward %i %i %@", zoneID, success, amount, currencyName);
	
	if (success) {
        [MFAdColony sharedAdColony].isSecondZoneWatched =YES;
        
		NSUserDefaults* storage = [NSUserDefaults standardUserDefaults];
		
//        [storage setBool:YES forKey:@"isVideoWatched"];
        
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = 1;
        
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *expireDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
        
        [storage setObject:expireDate forKey:@"expireDate"];
        [storage synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MFIsVideoWatched" object:nil];
		
        
	} else {
//		[[NSNotificationCenter defaultCenter] postNotificationName:@"MFZoneOff" object:nil];
	}
}



- ( void ) onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString*) zoneID {
	if(available) {
        if ([zoneID isEqualToString:@"vz3a0c719cb27b400cb1"]) {
            [MFAdColony sharedAdColony].isFirstZoneLoaded=YES;
        }else if ([zoneID isEqualToString:@"vz16512e0b8a19467b8e"]){
            [MFAdColony sharedAdColony].isSecondZoneLoaded=YES;
        }else if([zoneID isEqualToString:@"vz38df8ea2870f41d48e"]){
            [MFAdColony sharedAdColony].isThirdZoneLaoded =YES;
        }
		
	}else{
        if ([zoneID isEqualToString:@"vz3a0c719cb27b400cb1"]) {
            [MFAdColony sharedAdColony].isFirstZoneLoaded=NO;
        }else if ([zoneID isEqualToString:@"vz16512e0b8a19467b8e"]){
            [MFAdColony sharedAdColony].isSecondZoneLoaded=NO;
        }else if([zoneID isEqualToString:@"vz38df8ea2870f41d48e"]){
            [MFAdColony sharedAdColony].isThirdZoneLaoded =NO;
        }
    }
}
- (void)didCompleteRewardedVideo:(CBLocation)location
                      withReward:(int)reward {
    NSUserDefaults* storage = [NSUserDefaults standardUserDefaults];
    
    //        [storage setBool:YES forKey:@"isVideoWatched"];
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *expireDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    
    [storage setObject:expireDate forKey:@"expireDate"];
    [storage synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MFIsVideoWatched" object:nil];
}
#endif

#pragma mark - frameworks settings

-(void)frameworksSettings{
    [MFSounds sharedSound];
    [MKStoreManager sharedManager];
#ifdef MystieFree
    [Chartboost startWithAppId:@"53e858d01873da2f5f619e43" appSignature:@"3fa1918953a2213d56b22b93db70bb9d8ff2ae09" delegate:self];
    [Chartboost cacheRewardedVideo:CBLocationGameScreen];
    [AdColony configureWithAppID:@"app6452bf1c5bcc4cc782" zoneIDs:@[@"vz3a0c719cb27b400cb1", @"vz16512e0b8a19467b8e",@"vz38df8ea2870f41d48e"] delegate:self logging:YES];
    [MobileAppTracker initializeWithMATAdvertiserId:@"20460"
                                   MATConversionKey:@"e76deeecd77756a4861d9a10389124c7"];
    [MobileAppTracker setAppleAdvertisingIdentifier:[[ASIdentifierManager sharedManager] advertisingIdentifier]
                         advertisingTrackingEnabled:[[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]];
#endif
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-54008191-3"];
#ifdef MystieFree
    [MFAdColony sharedAdColony];
#endif

}

@end
