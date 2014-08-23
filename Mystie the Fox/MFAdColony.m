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
#import "AdColony.h"
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

@end
