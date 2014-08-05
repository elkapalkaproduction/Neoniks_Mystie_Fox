//
//  MFMosquito.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFMosquito.h"
#import "MFImageCropper.h"

#define ASSET_BY_SCREEN_HEIGHT(longScreen, regular) (([[UIScreen mainScreen] bounds].size.height == 568.0) ? longScreen : regular)

@interface MFMosquito ()

@property (nonatomic) BOOL isTapped;
@property (strong,nonatomic) SKSpriteNode * mosquito;
@property (strong , nonatomic) SKSpriteNode *wings;

@property (strong, nonatomic) SKAction * mosquitoFlying;
@property (strong,nonatomic) SKAction * mosquitoLightOn;

@end

@implementation MFMosquito

-(instancetype)initWithParent:(SKNode *)parent{
    [self loadSounds];
    if (self=[super initWithColor:[UIColor clearColor] size:CGSizeZero]) {
        self.mosquito = [SKSpriteNode spriteNodeWithImageNamed:@"mosquito-1.png"];
        self.wings = [SKSpriteNode spriteNodeWithImageNamed:@"wings.png"];
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            
            self.mosquito.size=[MFImageCropper sizeWith2xSprite:self.mosquito];
            self.size = [MFImageCropper sizeWith2xSprite:self.mosquito];
            self.size = CGSizeMake(self.size.width, 125.5);
            self.wings.size = [MFImageCropper sizeWith2xSprite:self.wings];
            if ([[UIScreen mainScreen] bounds].size.height != 568.0) {
                self.size = CGSizeMake(self.size.width *0.8, self.size.height *0.8);
            }
        }else{
            self.size =CGSizeMake(self.mosquito.size.width, self.mosquito.size.height);
        }
        self.mosquito.zPosition=0.1;
        self.mosquito.name=@"mosquitoCharacter";
        self.wings.anchorPoint = CGPointMake(0.5, 0);
        self.wings.position =CGPointMake(0, 0);
        [self addChild:self.mosquito];
        [self addChild:self.wings];
        self.position = [self rightRandomPosition:parent];
        
        SKAction *wingsMoving = [SKAction rotateByAngle:M_PI_4/8 duration:0.02];
        SKAction *wingsReverseMoving = [wingsMoving reversedAction];
        SKAction *sequence = [SKAction sequence:@[wingsMoving, wingsReverseMoving]];
        SKAction *foreverSequence = [SKAction repeatActionForever:sequence];
        [self.wings runAction:foreverSequence];
        self.removeNode = [SKAction removeFromParent];
        self.move = [self createMoveAction:parent];
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:7];
    move =[move reversedAction];
    
    SKAction *ufoSound = [SKAction runBlock:^{
        
    }];
    move = [SKAction group:@[move, self.mosquitoFlying]];
    return [SKAction sequence:@[move,self.removeNode]];
}

-(void)taped{
    SKAction *screechSound =[SKAction runBlock:^{
        
    }];
    SKAction *aliensSound =[SKAction runBlock:^{
        
    }];
    NSMutableArray * textures=[[NSMutableArray alloc] init];
    for (int i = 0; i<4; i++) {
        SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"mosquito-%d.png",i+1]];
        [textures addObject:texture];
    }
    SKAction * lightOnAnimation = [SKAction animateWithTextures:textures timePerFrame:0.08];
    if (!self.isTapped) {
        self.isTapped =YES;
        SKAction * group = [SKAction group:@[lightOnAnimation, self.mosquitoLightOn]];
        [self.mosquito runAction:group];
    }else{
        SKAction *lightOffAnimation = [lightOnAnimation reversedAction];
        self.isTapped =NO;
        SKAction * group = [SKAction group:@[lightOffAnimation, self.mosquitoLightOn]];
        [self.mosquito runAction:group];
        
    }
    
}

-(void)loadSounds{
    self.mosquitoFlying = [SKAction playSoundFileNamed:@"mosquito.mp3" waitForCompletion:NO];
    self.mosquitoLightOn = [SKAction playSoundFileNamed:@"light_on.mp3" waitForCompletion:NO];
}


@end
