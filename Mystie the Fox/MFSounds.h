//
//  MFSounds.h
//  Mystie the Fox
//
//  Created by Roman on 05.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MFSounds : NSObject

+(instancetype) sharedSound;
@property (strong,nonatomic) NSData *bugWind;
@property (strong,nonatomic) NSData *bugScream;
@property (strong, nonatomic) NSData * bugPuff;

@property(strong,nonatomic) NSData * dollFalling;
@property(strong,nonatomic) NSData * dollLaught;
@property(strong,nonatomic) NSData * dollOuch;

@property(strong,nonatomic) NSData * dragonSound;
@property(strong,nonatomic) NSData * dragonFire;

@property (strong,nonatomic) NSData *ghostFlying;
@property (strong,nonatomic) NSData *ghostSobbing;
@property (strong, nonatomic) NSData * ghostHole;

@property (strong,nonatomic) NSData *ufoFlying;
@property (strong,nonatomic) NSData *ufoAliens;
@property (strong, nonatomic) NSData * ufoScreech;

@property (strong, nonatomic) NSData * mosquitoFlying;
@property (strong,nonatomic) NSData * mosquitoLightOn;

@property (strong,nonatomic) NSData *catHelicopterOne;
@property (strong,nonatomic) NSData *catHelicopterTwo;
@property (strong, nonatomic) NSData * catMeow;

@property (strong,nonatomic) NSData *cloudFlying;
@property (strong,nonatomic) NSData *cloudThunder;



@end
