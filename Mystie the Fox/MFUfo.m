//
//  MFUfo.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFUfo.h"
#import "MFImageCropper.h"
#import "MFSounds.h"

@interface MFUfo ()

@property (nonatomic) BOOL isTapped;

@property (strong,nonatomic) AVAudioPlayer *ufoFlying;
@property (strong,nonatomic) AVAudioPlayer *ufoAliens;
@property (strong, nonatomic) AVAudioPlayer * ufoScreech;

@end

@implementation MFUfo

-(instancetype)initWithParent:(SKNode *)parent{
    [self loadSounds];
    if (self=[super initWithName:@"ufo.png"]) {
        self.name=@"ufoCharacter";
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            self.size = [MFImageCropper sizeWith2xSprite:self];
        }
        self.position = [self rightRandomPosition:parent];
        self.move=[self createMoveAction:parent];
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:7];
    move =[move reversedAction];
    SKAction * flyingSound= [SKAction runBlock:^{
        [self.ufoFlying play];
    }];
    SKAction * removeSounds = [SKAction runBlock:^{
        [self.ufoFlying stop];
        [self.ufoScreech stop];
        [self.ufoAliens stop];
        self.ufoFlying=nil;
        self.ufoAliens=nil;
        self.ufoScreech=nil;
    }];
    move = [SKAction group:@[move, flyingSound]];
    return [SKAction sequence:@[move, removeSounds, self.removeNode]];
}

-(void)taped{
    [self.ufoFlying stop];
    SKAction *screechSound = [SKAction runBlock:^{
        self.ufoScreech=nil;
        self.ufoScreech = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ufoScreech error:nil];
        [self.ufoScreech play];
    }];
    SKAction *alienSound = [SKAction runBlock:^{
        [self.ufoAliens play];
    }];
    SKAction * flyingSound= [SKAction runBlock:^{
        self.ufoFlying=nil;
        self.ufoFlying = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ufoFlying error:nil];
        self.ufoFlying.numberOfLoops=-1;
        [self.ufoFlying play];
    }];
    if (!self.isTapped) {
        SKAction *zRotation = [SKAction rotateByAngle:-M_PI_4 duration:1];
        self.isTapped =YES;
        SKAction *group = [SKAction group:@[zRotation, screechSound]];
        SKAction *sequence = [SKAction sequence:@[group , alienSound]];
        [self runAction:sequence];
    }else{
        [self.ufoAliens stop];
        SKAction *zRotation = [SKAction rotateByAngle:M_PI_4 duration:1];
        self.isTapped =NO;
        SKAction *group = [SKAction group:@[zRotation, screechSound]];
        SKAction * sequence = [SKAction sequence:@[group, flyingSound]];
        [self runAction:sequence];
        
    }
    
}

-(void)loadSounds{
    dispatch_queue_t soundQueue=dispatch_queue_create("soundQueue", NULL);
    dispatch_async(soundQueue, ^{
        self.ufoFlying = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ufoFlying error:nil];
        self.ufoFlying.numberOfLoops=-1;
        self.ufoScreech = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ufoScreech error:nil];
        self.ufoAliens = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ufoAliens error:nil];
    });
}

@end
