//
//  MFMosquito.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFMosquito.h"
#import "MFImageCropper.h"

@interface MFMosquito ()

@property (nonatomic) BOOL isTapped;
@property (strong,nonatomic) SKSpriteNode * mosquito;
@property (strong , nonatomic) SKSpriteNode *wings;

@end

@implementation MFMosquito

-(instancetype)initWithParent:(SKNode *)parent{
    if (self=[super initWithColor:[UIColor clearColor] size:CGSizeZero]) {
        self.mosquito = [SKSpriteNode spriteNodeWithImageNamed:@"mosquito-1.png"];
        self.wings = [SKSpriteNode spriteNodeWithImageNamed:@"wings.png"];
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            
            self.mosquito.size=[MFImageCropper sizeWith2xSprite:self.mosquito];
            self.size = [MFImageCropper sizeWith2xSprite:self.mosquito];
            self.size = CGSizeMake(self.size.width, 125.5);
            self.wings.size = [MFImageCropper sizeWith2xSprite:self.wings];
            
        }else{
            float ratio = [MFImageCropper spriteRatio:self.mosquito];
            float wingsRatio = [MFImageCropper spriteRatio:self.wings];
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
    //    SKAction *windSound = [SKAction playSoundFileNamed:@"ghost.mp3" waitForCompletion:NO];
    
    SKAction *ufoSound = [SKAction runBlock:^{
        
    }];
    move = [SKAction group:@[move, ufoSound]];
    //    SKAction * remove = [SKAction removeFromParent];
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
        [self.mosquito runAction:lightOnAnimation];
    }else{
        SKAction *lightOffAnimation = [lightOnAnimation reversedAction];
        self.isTapped =NO;
        [self.mosquito runAction:lightOffAnimation];
        
    }
    
}

@end
