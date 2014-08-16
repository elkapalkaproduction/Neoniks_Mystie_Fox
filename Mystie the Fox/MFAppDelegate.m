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

#import "MKStoreManager.h"
#import "Chartboost.h"


@implementation MFAppDelegate 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MFSounds sharedSound];
    [MKStoreManager sharedManager];
    [AdColony configureWithAppID:@"app6452bf1c5bcc4cc782" zoneIDs:@[@"vz3a0c719cb27b400cb1", @"vz16512e0b8a19467b8e"] delegate:self logging:YES];
    
    [self.window makeKeyAndVisible];
    
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
    
    
    // Override point for customization after application launch.
    return YES;
}
							
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
    [Chartboost startWithAppId:@"53e858d01873da2f5f619e43" appSignature:@"3fa1918953a2213d56b22b93db70bb9d8ff2ae09" delegate:self];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Custom Methods

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    [self.splashView removeFromSuperview];
}

- ( void ) onAdColonyV4VCReward:(BOOL)success currencyName:(NSString*)currencyName currencyAmount:(int)amount inZone:(NSString*)zoneID {
	NSLog(@"AdColony zone %@ reward %i %i %@", zoneID, success, amount, currencyName);
	
	if (success) {
		NSUserDefaults* storage = [NSUserDefaults standardUserDefaults];
		
        [storage setBool:YES forKey:@"isVideoWatched"];
        [storage synchronize];
		

	} else {
//		[[NSNotificationCenter defaultCenter] postNotificationName:@"MFZoneOff" object:nil];
	}
}

#pragma mark -
#pragma mark AdColony ad fill

- ( void ) onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString*) zoneID {
	if(available) {
        if ([zoneID isEqualToString:@"vz3a0c719cb27b400cb1"]) {
            [MFAdColony sharedAdColony].isFirstZoneLoaded=YES;
        }else if ([zoneID isEqualToString:@"vz16512e0b8a19467b8e"]){
            [MFAdColony sharedAdColony].isSecondZoneLoaded=YES;
        }
		
	}
}



@end
