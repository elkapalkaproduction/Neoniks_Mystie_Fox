//
//  MFDragon.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFDragon.h"
#import "MFImageCropper.h"
#import <AVFoundation/AVFoundation.h>


@interface MFDragon ()

@property (strong,nonatomic) SKSpriteNode *dragon;
@property (strong,nonatomic) SKSpriteNode *fire;

@property (strong,nonatomic) AVAudioPlayer *dragonSound;

@end

@implementation MFDragon

-(instancetype)initWithParent:(SKNode *)parent{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeZero]) {
        self.removeNode =[SKAction removeFromParent];
//        self.anchorPoint=CGPointMake(0, 0.5);
        self.dragon= [SKSpriteNode spriteNodeWithImageNamed:@"Dragon.png"];
        if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
            self.size=CGSizeMake(319.5 +250, 239.5);
            self.dragon.position=CGPointMake(125, 0);
        }else{
            float ratio = [MFImageCropper spriteRatio:self.dragon];
            self.size =CGSizeMake(133 +104, 133*ratio);
            self.dragon.size = CGSizeMake(133, 133*ratio);
            self.dragon.position=CGPointMake(52, 0);
        }
        
        self.dragon.name=@"dragonCharacter";
        [self addChild:self.dragon];
        self.position=[self rightRandomPosition:parent];
        [self loadSounds];
        self.move = [self createMoveAction:parent];
    }
    return self;
}

-(void)loadSounds{
    NSURL *urlDragon = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"dragon" ofType:@"mp3"]];
    self.dragonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:urlDragon error:nil];
}


-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:5];
    move =[move reversedAction];
//    SKAction *windSound = [SKAction playSoundFileNamed:@"dragon.mp3" waitForCompletion:NO];
    SKAction *dragonSound = [SKAction runBlock:^{
        [self.dragonSound play];
    }];
    move = [SKAction group:@[move, dragonSound]];
    return [SKAction sequence:@[move,self.removeNode]];
}

-(void)taped{
    [super taped];
    self.dragon.name =nil;
    [self.dragonSound stop];
    NSMutableArray * textures=[[NSMutableArray alloc] init];
    for (int i = 0; i<16; i++) {
        SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Fire-%d.png",i+1]];
        [textures addObject:texture];
    }
    CGSize fireSize ;
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
        fireSize = CGSizeMake(250, 105);
    }else{
        fireSize = CGSizeMake(104, 44);
    }
    self.fire = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:fireSize];
    self.fire.anchorPoint =CGPointMake(0, 0.5);
    self.fire.position =CGPointMake(-self.size.width/2, -self.size.height/16*3);
    [self addChild:self.fire];
    SKAction *fireAction = [SKAction animateWithTextures:textures timePerFrame:0.05 resize:NO restore:YES];
    SKAction *sound = [SKAction playSoundFileNamed:@"fire.mp3" waitForCompletion:NO];
    SKAction *moveTo = [SKAction moveTo:CGPointMake(self.parent.frame.size.width + self.size.width/2, self.position.y) duration:1];
    fireAction =[SKAction group:@[fireAction,sound]];
    [self.fire runAction:fireAction];
    moveTo =[SKAction sequence:@[moveTo,self.removeNode]];
    [self runAction:moveTo];
}

@end
