//
//  MFGhost.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFGhost.h"
#import "MFImageCropper.h"
#import "MFSounds.h"
#import "MFSizesSettings.h"
#import "MFAnimationsSettings.h"

#define ASSET_BY_SCREEN_HEIGHT(longScreen, regular) (([[UIScreen mainScreen] bounds].size.height == 568.0) ? longScreen : regular)

@interface MFGhost ()

@property (nonatomic) BOOL isTapped;

@property (strong,nonatomic) AVAudioPlayer *ghostFlying;
@property (strong,nonatomic) AVAudioPlayer *ghostSobbing;
@property (strong, nonatomic) AVAudioPlayer * ghostHole;

@end

@implementation MFGhost

-(instancetype)initWithParent:(SKNode *)parent{
    [self loadSounds];
    if (self=[super initWithName:@"Ghost-1.png"]) {
        self.name=@"ghostCharacter";
        float ratio = [MFImageCropper spriteRatio:self];
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            self.size = CGSizeMake( ASSET_BY_SCREEN_HEIGHT(130, 90), ASSET_BY_SCREEN_HEIGHT(130, 90) *ratio );
//            self.size = CGSizeMake(kGhostWidthIphone, kGhostHeightIphone);
        }else{
            self.size =CGSizeMake(200, 200*ratio);
        }
        self.position = [self rightRandomPosition:parent];
        self.move = [self createMoveAction:parent];
        
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:kGhostFlyingDuration];
    move =[move reversedAction];
    SKAction *ghostSound = [SKAction runBlock:^{
        [self.ghostFlying play];
    }];
    SKAction * removeSounds = [SKAction runBlock:^{
        [self.ghostFlying stop];
        [self.ghostHole stop];
        [self.ghostSobbing stop];
        self.ghostFlying=nil;
        self.ghostHole=nil;
        self.ghostSobbing=nil;
    }];
    move = [SKAction group:@[move, ghostSound]];
    return [SKAction sequence:@[move, removeSounds, self.removeNode]];
}

-(void)taped{
    [self.ghostFlying stop];
    NSMutableArray * textures=[[NSMutableArray alloc] init];
    for (int i = 0; i<6; i++) {
        SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Ghost-%d.png",i+1]];
        [textures addObject:texture];
    }
    SKAction *holeAction= [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *ghostHole = [SKAction runBlock:^{
        [self.ghostHole play];
    }];
    SKAction *ghostSobbing = [SKAction runBlock:^{
        [self.ghostSobbing play];
    }];
    SKAction *ghostSound = [SKAction runBlock:^{
        self.ghostFlying=nil;
        self.ghostFlying = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ghostFlying error:nil];
        self.ghostFlying.numberOfLoops=-1;
        [self.ghostFlying play];
    }];
    if (!self.isTapped) {
        self.isTapped =YES;
        
        holeAction = [SKAction group:@[holeAction,ghostHole, ghostSobbing]];
        [self runAction:holeAction];
    }else{
        holeAction =[holeAction reversedAction];
        self.isTapped =NO;
        holeAction =[SKAction group:@[holeAction,ghostHole]];
        SKAction *sequence = [SKAction sequence:@[holeAction , ghostSound]];
        [self runAction:sequence];
    }
    
}

-(void)loadSounds{
//    dispatch_queue_t soundQueue=dispatch_queue_create("soundQueue", NULL);
//    dispatch_async(soundQueue, ^{
        self.ghostFlying = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ghostFlying error:nil];
        self.ghostFlying.numberOfLoops=-1;
        self.ghostSobbing = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ghostSobbing error:nil];
        self.ghostHole = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].ghostHole error:nil];
//    });
}

-(void)fadeAwaySound{
    [super fadeAwaySound];
    if (self.ghostFlying.volume > 0.1) {
        self.ghostFlying.volume = self.ghostFlying.volume - 0.1;
        [self performSelector:@selector(fadeAwaySound) withObject:nil afterDelay:0.1];
    } else {
        // Stop and get the sound ready for playing again
//        [self.ghostFlying stop];
//        self.ghostFlying.currentTime = 0;
        
    }
}

@end
