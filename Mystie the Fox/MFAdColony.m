//
//  MFAdColony.m
//  Mystie the Fox
//
//  Created by Roman on 16.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFAdColony.h"
#import <SpriteKit/SpriteKit.h>
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#ifdef MystieFree
#import "AdColony.h"
#endif
/*
 1.  App Started
 2.  Who is Mystie clicked
 3.  neoniks website clicked
 4.  Start clicked
 (Who is Mystie screen):
 5.  Play clicked
 6.  More clicked
 (Play screen)
 7.  More on Play clicked
 8.  Mystie is clicked
 9.  Character 1 clicked
 10. Character 2 clicked
 11.  Character 3 clicked
 12.  Character 4 clicked
 13.  Character 5 clicked
 14. Character 6 clicked
 15. Character 7 clicked
 16. Character 8 clicked
 17.  In-App Yes clicked
 18. In-App No clicked
 19.  Video Yes clicked
 20 Video No clicked
 */
NSString *const EVENT_MAIN_APP_STARTED = @"EVENT_MAIN_APP_STARTED";
NSString *const EVENT_MAIN_WHO_IS_MISTY = @"EVENT_MAIN_WHO_IS_MISTY";
NSString *const EVENT_MAIN_NEONIKS_WEBSITE = @"EVENT_MAIN_NEONIKS_WEBSITE";
NSString *const EVENT_MAIN_START_CLICKED = @"EVENT_MAIN_START_CLICKED";
NSString *const EVENT_WHO_IS_MISTY_PLAY = @"EVENT_WHO_IS_MISTY_PLAY";
NSString *const EVENT_WHO_IS_MISTY_MORE = @"EVENT_WHO_IS_MISTY_MORE";
NSString *const EVENT_PLAY_MORE = @"EVENT_PLAY_MORE";
NSString *const EVENT_PLAY_MISTY = @"EVENT_PLAY_MISTY";
NSString *const EVENT_PLAY_CHAR = @"EVENT_PLAY_";
NSString *const EVENT_IN_APP_YES = @"EVENT_IN_APP_YES";
NSString *const EVENT_IN_APP_NO = @"EVENT_IN_APP_NO";
NSString *const EVENT_VIDEO_YES = @"EVENT_VIDEO_YES";
NSString *const EVENT_VIDEO_NO = @"EVENT_VIDEO_NO";


NSString *const GOOGLE_ANALITYCS_TRACKING_ID = @"UA-33114261-6";

@implementation MFAdColony

+(instancetype) sharedAdColony{
    
    static MFAdColony *sharedAdColony = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAdColony = [[self alloc] init];
    });
    return sharedAdColony;
    
}

-(instancetype) init{
    if (self==[super init]) {
        [GAI sharedInstance].trackUncaughtExceptions = YES;
        [GAI sharedInstance].dispatchInterval = 20;
        [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelNone];
        [[GAI sharedInstance] trackerWithTrackingId:GOOGLE_ANALITYCS_TRACKING_ID];

#ifdef MystieFree
        self.interstitialView = [[GADInterstitial alloc] init];
        self.interstitialView.delegate=self;
        self.interstitialView.adUnitID = @"ca-app-pub-1480731978958686/7886942590";
        [self.interstitialView loadRequest:[GADRequest request]];
#endif
        
        
    }
    return self;
}
#pragma mark - GA
#ifdef MystieFree
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial{
//    [self.interstitialView presentFromRootViewController:[self.view nextResponder]];
    self.isInterstitialRequestLoaded=YES;
}

- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error{
    self.isInterstitialRequestLoaded=NO;
}


-(void) showGADInterstitialWithParent:(UIViewController *)parent{
    self.parentForGA =parent;
    [self.interstitialView presentFromRootViewController:parent];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)interstitial{
    ((SKView*)self.parentForGA.view).paused=YES;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial{
    ((SKView*)self.parentForGA.view).paused=NO;
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)interstitial{
    ((SKView*)self.parentForGA.view).paused=NO;
}

#pragma mark - AC

-(void)onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneID
{
    NSLog(@"%@ self.parentForAc", self.parentForAC);
    ((SKView*)self.parentForAC.view).paused=NO;
}
-(void)onAdColonyAdStartedInZone:(NSString *)zoneID
{
    ((SKView*)self.parentForAC.view).paused=YES;
}

-(void)playAdColonyVidioWithParent:(UIViewController *)parent zone:(NSString *) zone{
    self.parentForAC=parent;
    [AdColony playVideoAdForZone:zone withDelegate:self];
}
#endif


- (void)logEvent:(NSString *)event {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                           action:event
                                                            label:nil
                                                            value:nil] set:@"start" forKey:kGAISessionControl] build]];
}

@end
