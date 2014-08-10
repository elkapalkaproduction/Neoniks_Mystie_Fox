//
//  MFCat.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFCat.h"
#import "MFImageCropper.h"
#import "MFSounds.h"
#import "MFAnimationsSettings.h"

@interface MFCat ()

@property (nonatomic) BOOL isTapped;

@property (nonatomic) float speed;

@property (strong,nonatomic) AVAudioPlayer *catHelicopterOne;
@property (strong,nonatomic) AVAudioPlayer *catHelicopterTwo;
@property (strong, nonatomic) AVAudioPlayer * catMeow;


@end

@implementation MFCat

-(instancetype)initWithParent:(SKNode *)parent{
    [self loadSounds];
    if (self=[super initWithName:@"cat-1.png"]) {
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
        self.move = [self createMoveAction:parent];
        
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:kCatFlyingDuration];
    move =[move reversedAction];
    SKAction * flyingSound= [SKAction runBlock:^{
        [self.catHelicopterOne play];
    }];
    SKAction * removeSounds = [SKAction runBlock:^{
        [self.catHelicopterOne stop];
        [self.catHelicopterTwo stop];
        [self.catMeow stop];
        self.catHelicopterOne=nil;
        self.catHelicopterTwo=nil;
        self.catMeow=nil;
    }];
    
    move = [SKAction group:@[move, flyingSound]];
    return [SKAction sequence:@[move, removeSounds, self.removeNode]];
}

-(void)taped{
    [self.catHelicopterOne stop];
    [self.catHelicopterTwo stop];
    [self.catMeow stop];
    SKAction *catHelicopterTwo =[SKAction runBlock:^{
        [self.catHelicopterTwo play];
    }];
    SKAction *catMeow =[SKAction runBlock:^{
        self.catMeow.currentTime = 0;
        [self.catMeow prepareToPlay];
        [self.catMeow play];
    }];
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
    SKAction *soundSequence = [SKAction sequence:@[catMeow, catHelicopterTwo]];
    [self runAction:sequence];
    [self runAction:soundSequence];
    self.speed = self.speed *2.0f;
    
    
}

-(void)loadSounds{
//    dispatch_queue_t soundQueue=dispatch_queue_create("soundQueue", NULL);
//    dispatch_async(soundQueue, ^{
        self.catHelicopterOne = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].catHelicopterOne error:nil];
        self.catHelicopterOne.numberOfLoops=-1;
        self.catHelicopterTwo = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].catHelicopterTwo error:nil];
        self.catMeow = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].catMeow error:nil];
//    });
}

-(void)fadeAwaySound{
    [super fadeAwaySound];
    if (self.catHelicopterOne.volume > 0.1) {
        self.catHelicopterOne.volume = self.catHelicopterOne.volume - 0.1;
        [self performSelector:@selector(fadeAwaySound) withObject:nil afterDelay:0.1];
    } else {
        // Stop and get the sound ready for playing again
        [self.catHelicopterOne stop];
        self.catHelicopterOne.currentTime = 0;
        
    }
    
    if (self.catHelicopterTwo.volume > 0.1) {
        self.catHelicopterTwo.volume = self.catHelicopterTwo.volume - 0.1;
        [self performSelector:@selector(fadeAwaySound) withObject:nil afterDelay:0.1];
    } else {
        // Stop and get the sound ready for playing again
//        [self.catHelicopterTwo stop];
//        self.catHelicopterTwo.currentTime = 0;
        
    }
    
}



@end
