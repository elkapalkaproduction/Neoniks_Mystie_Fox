//
//  MFAdColony.h
//  Mystie the Fox
//
//  Created by Roman on 16.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef MystieFree
#import "GADInterstitial.h"
#endif

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
#endif
@property (nonatomic)BOOL isInterstitialRequestLoaded;

-(void) showGADInterstitialWithParent:(UIViewController *)parent;
-(void)playAdColonyVidioWithParent:(UIViewController*)parent zone:(NSString*)zone;

@end
