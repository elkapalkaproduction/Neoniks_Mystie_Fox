//
//  MFCloud.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFCloud.h"
#import "MFImageCropper.h"
#import "MFFirstPageScene.h"
#import "MFSounds.h"
#import "MFSizesSettings.h"
#import "MFAnimationsSettings.h"

#define ASSET_BY_SCREEN_HEIGHT(longScreen, regular) (([[UIScreen mainScreen] bounds].size.height == 568.0) ? longScreen : regular)

@interface MFCloud ()

@property (nonatomic) BOOL isTapped;

@property (strong,nonatomic) AVAudioPlayer *cloudFlying;
@property (strong,nonatomic) AVAudioPlayer *cloudThunder;

@end

@implementation MFCloud

-(instancetype)initWithParent:(SKNode *)parent{
    [self loadSounds];
    if (self=[super initWithName:@"cloud-1.png"]) {
        self.name=@"cloudCharacter";
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            self.size = [MFImageCropper sizeWith2xSprite:self];
//            self.size = CGSizeMake(kCloudWidthIphone, kCloudHeightIphone);
        }else{

        }

        self.position = [self rightRandomPosition:parent];
        self.move = [self createMoveAction:parent];
        
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:kCloudFlyingDuration];
    move =[move reversedAction];
    SKAction * flyingSound= [SKAction runBlock:^{
        [self.cloudFlying play];
    }];
    SKAction * removeSounds = [SKAction runBlock:^{
        [self.cloudFlying stop];
        [self.cloudThunder stop];
        self.cloudFlying=nil;
        self.cloudThunder=nil;
    }];
    
    move = [SKAction group:@[move, flyingSound]];
    return [SKAction sequence:@[move,removeSounds, self.removeNode]];
}

-(void)taped{
    SKAction *cloudThunder =[SKAction runBlock:^{
        self.cloudThunder.currentTime =0;
        [self.cloudThunder prepareToPlay];
        [self.cloudThunder play];
    }];
    NSMutableArray * textures=[[NSMutableArray alloc] init];
    for (int i = 0; i<6; i++) {
        SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"cloud-%d.png",i+1]];
        [textures addObject:texture];
    }
    SKTexture *texture2 = [[textures objectAtIndex:1] copy];
    [textures addObject:texture2];
    SKTexture *texture = [[textures objectAtIndex:0] copy];
    [textures addObject:texture];
    float timePerFrame = 0.1;
    
    SKAction *animate = [SKAction animateWithTextures:textures timePerFrame:timePerFrame];
    SKSpriteNode * whiteScreen = [SKSpriteNode spriteNodeWithImageNamed:@"white_background.png"];
    whiteScreen.size = self.parent.frame.size;
    whiteScreen.position = CGPointMake(CGRectGetMidX(self.parent.frame), CGRectGetMidY(self.parent.frame));
    whiteScreen.zPosition =1;
    SKSpriteNode * skeleton = [SKSpriteNode spriteNodeWithImageNamed:@"skeleton.png"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        skeleton.size = [MFImageCropper sizeWith2xSprite:skeleton];
        skeleton.position=CGPointMake(0 + whiteScreen.size.width/30, 0 - ASSET_BY_SCREEN_HEIGHT(whiteScreen.size.height/7, whiteScreen.size.height/15));
    }else{
        skeleton.position=CGPointMake(0, -40);
    }
    [whiteScreen addChild:skeleton];
    
    __weak MFFirstPageScene *scene = self.parent;
    SKAction * whiteScreenOn = [SKAction runBlock:^{
        scene.leftArrow.hidden =YES;
        scene.rightArrow.hidden =YES;
        [scene addChild:whiteScreen];
        
    }];
    SKAction * whiteScreenOff = [SKAction runBlock:^{
        scene.leftArrow.hidden =NO;
        scene.rightArrow.hidden =NO;
        [whiteScreen removeFromParent];
        
    }];
    SKAction *wait = [SKAction waitForDuration:0.3];
    whiteScreenOn = [SKAction group:@[whiteScreenOn, cloudThunder]];
    animate = [SKAction sequence:@[animate,whiteScreenOn,wait,whiteScreenOff]];
    [self runAction:animate ];
    
}

-(void)loadSounds{
    self.cloudFlying = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].cloudFlying error:nil];
    self.cloudFlying.numberOfLoops=-1;
    self.cloudThunder = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].cloudThunder error:nil];
}

-(void)fadeAwaySound{
    [super fadeAwaySound];
    if (self.cloudFlying.volume > 0.1) {
        self.cloudFlying.volume = self.cloudFlying.volume - 0.1;
        [self performSelector:@selector(fadeAwaySound) withObject:nil afterDelay:0.1];
    } else {
        // Stop and get the sound ready for playing again
//        [self.cloudFlying stop];
//        self.cloudFlying.currentTime = 0;
        
    }
}

@end
