//
//  MFBug.m
//  Mystie the Fox
//
//  Created by Roman on 28.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFBug.h"
#import "MFImageCropper.h"
#import "MFSounds.h"

@interface MFBug ()

@property (strong,nonatomic) AVAudioPlayer *bugWind;
@property (strong,nonatomic) AVAudioPlayer *bugScream;
@property (strong, nonatomic) AVAudioPlayer * bugPuff;

@end

@implementation MFBug

-(instancetype) initWithParent:(SKNode*)parent{
    [self loadSounds];
    self.particles =[[NSMutableArray alloc] init];
    if (self=[super initWithName:@"bug.png"]) {
        self.name=@"bugCharacter";
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            float ratio = [MFImageCropper spriteRatio:self];
            self.size = CGSizeMake(75, 75*ratio);
            
            for (int i=0; i<16; i++) {
                SKSpriteNode * particle =[SKSpriteNode spriteNodeWithImageNamed:@"stamen.png"];
                float particleRatio = [MFImageCropper spriteRatio:particle];
                particle.size =CGSizeMake(21, 21*particleRatio);
                particle.anchorPoint =CGPointMake(0.3, 0);
                CGPoint position =CGPointMake(-self.size.width/4 -2, self.size.height/2-18);
                particle.position = position;//[self convertPoint:position toNode:parent];
                particle.zRotation = M_PI_4/2 *i;
                particle.name =@"particle";
                [self addChild:particle];
                [self.particles addObject:particle];
            }
            
        }else{
            for (int i=0; i<16; i++) {
                SKSpriteNode * particle =[SKSpriteNode spriteNodeWithImageNamed:@"stamen.png"];
                particle.anchorPoint =CGPointMake(0.3, 0);
                CGPoint position =CGPointMake(-self.size.width/4 -2, self.size.height/2-40);//18
                particle.position = position;//[self convertPoint:position toNode:parent];
                particle.zRotation = M_PI_4/2 *i;
                particle.name =@"particle";
                [self addChild:particle];
                [self.particles addObject:particle];
            }
        }
        self.position =[self rightRandomPosition:parent];
        self.move=[self createMoveAction:parent];
    }
    return self;
}




-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:5];
    move =[move reversedAction];
    SKAction *windSound = [SKAction runBlock:^{
        [self.bugWind play];
    }];
    SKAction * removeSounds = [SKAction runBlock:^{
        [self.bugWind stop];
        [self.bugScream stop];
        [self.bugPuff stop];
        self.bugWind=nil;
        self.bugScream=nil;
        self.bugPuff=nil;
    }];
    move = [SKAction group:@[move, windSound]];
    return [SKAction sequence:@[move,removeSounds, self.removeNode]];
}

-(void)taped{
    [super taped];
    [self.bugWind stop];
    SKAction * remove = [SKAction removeFromParent];
    for (SKSpriteNode *particle in self.particles) {
        [particle removeAllActions];
        CGFloat rad = particle.zRotation;
        float tang = tan(rad);
        float positionY;
        float positionX;
        positionY = self.parent.frame.size.height - particle.position.y + particle.size.height/2;
        positionX = tang * positionY;

        particle.name =nil;
        
        SKAction * moveTo = [SKAction moveTo:CGPointMake(positionX, positionY+self.parent.frame.size.height *2.5) duration:3];
        SKAction *rotation = [SKAction rotateToAngle:0 duration:0.5];
        moveTo = [SKAction group:@[moveTo,rotation]];
        SKAction * sequence = [SKAction sequence:@[moveTo , remove]];
        [particle runAction:sequence];
    }
    SKAction * scream = [SKAction runBlock:^{
        [self.bugScream play];
    }];
    SKAction *puff =[SKAction runBlock:^{
        [self.bugPuff play];
    }];
    
    SKAction * moveDown = [SKAction moveByX:0 y:-self.position.y -self.size.height/2 duration:1];
    
    SKAction * downGroup = [SKAction group:@[scream,moveDown]];
    SKAction * removeSounds = [SKAction runBlock:^{
        [self.bugWind stop];
        [self.bugScream stop];
        [self.bugPuff stop];
        self.bugWind=nil;
        self.bugScream=nil;
        self.bugPuff=nil;
    }];
    SKAction *sequence =[SKAction sequence:@[puff, downGroup, removeSounds, remove] ];
    [self runAction:sequence];
}

-(void)loadSounds{
//    dispatch_queue_t soundQueue=dispatch_queue_create("soundQueue", NULL);
//    dispatch_async(soundQueue, ^{
        self.bugWind = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].bugWind error:nil];
        self.bugWind.numberOfLoops=-1;
        self.bugScream = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].bugScream error:nil];
        self.bugPuff = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].bugPuff error:nil];
//    });
}

-(void)fadeAwaySound{
    [super fadeAwaySound];
    if (self.bugWind.volume > 0.1) {
        self.bugWind.volume = self.bugWind.volume - 0.1;
        [self performSelector:@selector(fadeAwaySound) withObject:nil afterDelay:0.1];
    } else {
        // Stop and get the sound ready for playing again
//        [self.bugWind stop];
//        self.bugWind.currentTime = 0;

    }
}

@end
