//
//  MFAdColony.m
//  Mystie the Fox
//
//  Created by Roman on 16.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFAdColony.h"
#import <SpriteKit/SpriteKit.h>

#ifdef MystieFree
#import <AdColony/AdColony.h>
#import <Chartboost/Chartboost.h>
#import <StartApp/StartApp.h>
#endif

NSString *const START_APP_DEVELOPER_KEY = @"105068540";
NSString *const START_APP_APP_KEY = @"210300540";



#ifdef MystieFree
@interface MFAdColony () <STADelegateProtocol>
@property (strong, nonatomic) STAStartAppAd *appAd;

@end
#endif

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
#ifdef MystieFree
        STAStartAppSDK* sdk = [STAStartAppSDK sharedInstance];
        sdk.appID = START_APP_APP_KEY;
        sdk.devID = START_APP_DEVELOPER_KEY;
        [self.appAd loadAdWithDelegate:self];

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
- (void)showSplashAd {
    [Chartboost showInterstitial:CBLocationHomeScreen];
    [self.appAd showAd];
}

- (STAStartAppAd *)appAd {
    if (!_appAd) {
        _appAd = [[STAStartAppAd alloc] init];
    }
    
    return _appAd;
}

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
- (void)didCloseAd:(STAAbstractAd *)ad {
    self.appAd = nil;
    [self.appAd loadAdWithDelegate:self];
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

@end
