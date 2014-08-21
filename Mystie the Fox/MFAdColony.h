//
//  MFAdColony.h
//  Mystie the Fox
//
//  Created by Roman on 16.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADInterstitial.h"

@interface MFAdColony : NSObject

+(instancetype) sharedAdColony;

@property(nonatomic)BOOL isFirstZoneLoaded;
@property(nonatomic)BOOL isSecondZoneLoaded;

@property(nonatomic) BOOL isSecondZoneWatched;

@property (weak,nonatomic) UIViewController * parentForGA;
@property (weak,nonatomic) UIViewController * parentForAC;

@property (strong,nonatomic) GADInterstitial *interstitialView;
@property (nonatomic)BOOL isInterstitialRequestLoaded;

-(void) showGADInterstitialWithParent:(UIViewController *)parent;
-(void)playAdColonyVidioWithParent:(UIViewController*)parent;

@end
