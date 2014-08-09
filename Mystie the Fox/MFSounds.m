//
//  MFSounds.m
//  Mystie the Fox
//
//  Created by Roman on 05.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFSounds.h"

@implementation MFSounds

+(instancetype) sharedSound{
    
    static MFSounds *sharedSound = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSound = [[self alloc] init];
    });
    return sharedSound;
    
}

-(instancetype) init{
    if (self==[super init]) {
        [self loadSounds];
    }
    return self;
}

-(void)loadSounds{
    NSURL *urlBugWind = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"wind" ofType:@"mp3"]];
    self.bugWind = [NSData dataWithContentsOfURL:urlBugWind];
    NSURL *urlBugScream = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"scream2" ofType:@"mp3"]];
    self.bugScream = [NSData dataWithContentsOfURL:urlBugScream];
    NSURL *urlBugPuff = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"puff" ofType:@"mp3"]];
    self.bugPuff = [NSData dataWithContentsOfURL:urlBugPuff];
    
    
    NSURL *urlFalling = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"doll_falling" ofType:@"mp3"]];
   self.dollFalling = [NSData dataWithContentsOfURL:urlFalling];
    NSURL *urlLaught = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"doll_laughs_3" ofType:@"mp3"]];
    self.dollLaught = [NSData dataWithContentsOfURL:urlLaught];
    NSURL *urlOuch = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ouch" ofType:@"mp3"]];
    self.dollOuch = [NSData dataWithContentsOfURL:urlOuch];
    
    NSURL *urlDragon = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"dragon" ofType:@"mp3"]];
    self.dragonSound = [NSData dataWithContentsOfURL:urlDragon];
    NSURL *urlDragonFire = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"fire" ofType:@"mp3"]];
    self.dragonFire = [NSData dataWithContentsOfURL:urlDragonFire];
    
    NSURL *urlGhostFlying = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ghost" ofType:@"mp3"]];
    self.ghostFlying = [NSData dataWithContentsOfURL:urlGhostFlying];
    NSURL *urlGhostHole = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"hole" ofType:@"mp3"]];
    self.ghostHole = [NSData dataWithContentsOfURL:urlGhostHole];
    NSURL *urlGhostSobbing = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sobbing" ofType:@"mp3"]];
    self.ghostSobbing = [NSData dataWithContentsOfURL:urlGhostSobbing];
    
    NSURL *urlUfoFlying = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ufo" ofType:@"mp3"]];
    self.ufoFlying = [NSData dataWithContentsOfURL:urlUfoFlying];
    NSURL *urlUfoScreech = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"screech" ofType:@"mp3"]];
    self.ufoScreech = [NSData dataWithContentsOfURL:urlUfoScreech];
    NSURL *urlUfoAliens = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"aliens" ofType:@"mp3"]];
    self.ufoAliens = [NSData dataWithContentsOfURL:urlUfoAliens];
    
    NSURL *urlMosquitoFlying = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mosquito" ofType:@"mp3"]];
    self.mosquitoFlying = [NSData dataWithContentsOfURL:urlMosquitoFlying];
    NSURL *urlMosquitoLightOn = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"light_on" ofType:@"mp3"]];
    self.mosquitoLightOn = [NSData dataWithContentsOfURL:urlMosquitoLightOn];
    
    NSURL *urlCatHelicopterOne = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"helicopter1" ofType:@"mp3"]];
    self.catHelicopterOne = [NSData dataWithContentsOfURL:urlCatHelicopterOne];
    NSURL *urlCatHelicopterTwo = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"helicopter2" ofType:@"mp3"]];
    self.catHelicopterTwo = [NSData dataWithContentsOfURL:urlCatHelicopterTwo];
    NSURL *urlCatMeow = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"meow" ofType:@"mp3"]];
    self.catMeow = [NSData dataWithContentsOfURL:urlCatMeow];
    
    NSURL *urlCloudFlying = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cloud" ofType:@"mp3"]];
    self.cloudFlying = [NSData dataWithContentsOfURL:urlCloudFlying];
    NSURL *urlCloudThunder = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"thunder" ofType:@"mp3"]];
    self.cloudThunder = [NSData dataWithContentsOfURL:urlCloudThunder];
    
    
}

@end
