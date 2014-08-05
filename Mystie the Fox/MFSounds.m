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
    NSURL *urlFalling = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"doll_falling" ofType:@"mp3"]];
    self.dollFalling = [[AVAudioPlayer alloc] initWithContentsOfURL:urlFalling error:nil];
    [self.dollFalling prepareToPlay];
    
    NSURL *urlLaught = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"doll_laughs_3" ofType:@"mp3"]];
    self.dollLaught =[[AVAudioPlayer alloc] initWithContentsOfURL:urlLaught error:nil];
    [self.dollLaught prepareToPlay];
    
    NSURL *urlOuch = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ouch" ofType:@"mp3"]];
    self.dollOuch = [[AVAudioPlayer alloc] initWithContentsOfURL:urlOuch error:nil];
    [self.dollOuch prepareToPlay];
}

@end
