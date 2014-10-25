//
//  MFAdColony.h
//  Mystie the Fox
//
//  Created by Roman on 16.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAIDictionaryBuilder.h"
#ifdef MystieFree
#import "GADInterstitial.h"
#endif

NSString *const EVENT_MAIN_APP_STARTED;
NSString *const EVENT_MAIN_WHO_IS_MISTY;
NSString *const EVENT_MAIN_NEONIKS_WEBSITE;
NSString *const EVENT_MAIN_START_CLICKED;
NSString *const EVENT_WHO_IS_MISTY_PLAY;
NSString *const EVENT_WHO_IS_MISTY_MORE;
NSString *const EVENT_PLAY_MORE;
NSString *const EVENT_PLAY_MISTY;
NSString *const EVENT_PLAY_CHAR;
NSString *const EVENT_IN_APP_YES;
NSString *const EVENT_IN_APP_NO;
NSString *const EVENT_VIDEO_YES;
NSString *const EVENT_VIDEO_NO;

@interface MFAdColony : NSObject

+(instancetype) sharedAdColony;

@property(nonatomic)BOOL isFirstZoneLoaded;
@property(nonatomic)BOOL isSecondZoneLoaded;
@property(nonatomic) BOOL isThirdZoneLaoded;

@property(nonatomic) BOOL isSecondZoneWatched;

@property (weak,nonatomic) UIViewController * parentForGA;
@property (weak,nonatomic) UIViewController * parentForAC;
#ifdef MystieFree
@property (strong,nonatomic) GADInterstitial *interstitialView;
- (void)showSplashAd;
#endif
@property (strong, nonatomic) GAIDictionaryBuilder *builder;
@property (nonatomic)BOOL isInterstitialRequestLoaded;

-(void) showGADInterstitialWithParent:(UIViewController *)parent;
-(void)playAdColonyVidioWithParent:(UIViewController*)parent zone:(NSString*)zone;

- (void)logEvent:(NSString *)event;
- (void)startSessionRecorderForScreen:(NSString *)screen;
- (void)stopRecording;

@end
