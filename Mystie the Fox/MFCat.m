//
//  MFCat.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFCat.h"
#import "MFImageCropper.h"

@interface MFCat ()

@property (nonatomic) BOOL isTapped;

@property (nonatomic) float speed;

@property (strong,nonatomic) SKAction *catHelicopterOne;
@property (strong,nonatomic) SKAction *catHelicopterTwo;
@property (strong, nonatomic) SKAction * catMeow;


@end

@implementation MFCat

-(instancetype)initWithParent:(SKNode *)parent{
    [self loadSounds];
    if (self=[super initWithName:@"cat-1.png" parent:parent]) {
        self.name=@"catCharacter";
        SKSpriteNode * bigPropeller = [SKSpriteNode spriteNodeWithImageNamed:@"propeller-big.png"];
        SKSpriteNode * smallPropeller = [SKSpriteNode spriteNodeWithImageNamed:@"propeller-small.png"];
        float ratio = [MFImageCropper spriteRatio:self];
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            self.size = CGSizeMake( 130, 130 *ratio );
            bigPropeller.size = [MFImageCropper sizeWith2xSprite:bigPropeller];
            smallPropeller.size = [MFImageCropper sizeWith2xSprite:smallPropeller];
            bigPropeller.position = CGPointMake(0 -4, self.size.height/2 -5);
            smallPropeller.position = CGPointMake(self.size.width/2 -17, 8);
        }else{
            self.size =CGSizeMake(200, 200*ratio);
            bigPropeller.position = CGPointMake(0 -4 *2.4 +5, self.size.height/2 -5*2.4 +2);
            smallPropeller.position = CGPointMake(self.size.width/2-27, 14);
        }
        
        SKAction *propellerMoving = [SKAction rotateByAngle:M_PI_4/8 duration:0.02];
        SKAction *propellerReverseMoving = [propellerMoving reversedAction];
        SKAction *sequence = [SKAction sequence:@[propellerMoving, propellerReverseMoving]];
        SKAction *foreverSequence = [SKAction repeatActionForever:sequence];
        [bigPropeller runAction:foreverSequence];
        [smallPropeller runAction: foreverSequence];
        
        [self addChild:smallPropeller];
        [self addChild:bigPropeller];
        self.position = [self rightRandomPosition:parent];
        
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:7];
    move =[move reversedAction];
    
    move = [SKAction group:@[move, self.catHelicopterOne]];
    return [SKAction sequence:@[move,self.removeNode]];
}

-(void)taped{
    NSMutableArray * textures=[[NSMutableArray alloc] init];
    for (int i = 0; i<4; i++) {
        SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"cat-%d.png",i+1]];
        [textures addObject:texture];
    }
    float timePerFrame = 0.15;
    SKAction * catAnimation = [SKAction animateWithTextures:textures timePerFrame:timePerFrame];
    SKAction * wait = [SKAction waitForDuration:timePerFrame *3];
    SKAction *reverseCatAnimation = [catAnimation reversedAction];
    SKAction *sequence = [SKAction sequence:@[catAnimation,wait,reverseCatAnimation]];
    SKAction *soundSequence = [SKAction sequence:@[self.catMeow, self.catHelicopterTwo]];
    [self runAction:sequence];
    [self runAction:soundSequence];
    self.speed = self.speed *2.0f;
    
    
}

-(void)loadSounds{
    self.catHelicopterOne = [SKAction playSoundFileNamed:@"helicopter1.mp3" waitForCompletion:NO];
    self.catHelicopterTwo = [SKAction playSoundFileNamed:@"helicopter1.mp3" waitForCompletion:NO];
    self.catMeow = [SKAction playSoundFileNamed:@"meow.mp3" waitForCompletion:NO];
}



@end
