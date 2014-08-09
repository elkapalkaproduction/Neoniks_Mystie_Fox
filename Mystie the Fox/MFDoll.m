//
//  MFDoll.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFDoll.h"
#import "MFImageCropper.h"
#import <AVFoundation/AVFoundation.h>
#import "MFSounds.h"

@interface MFDoll ()
@property(strong,nonatomic) SKSpriteNode *doll;
@property(getter = isParachuteOpened, nonatomic) BOOL parachuteOpened;

@property (strong,nonatomic) SKAction *moveDown;

@property (strong,nonatomic) AVAudioPlayer *dollFalling;
@property (strong,nonatomic) AVAudioPlayer *dollLaught;
@property (strong,nonatomic) AVAudioPlayer *dollOuch;

@end

@implementation MFDoll

-(instancetype)initWithParent:(SKNode *)parent{
    if (self = [super initWithColor:[UIColor clearColor] size:CGSizeZero]) {
        self.removeNode =[SKAction removeFromParent];
        self.anchorPoint=CGPointMake(0.5, 0);
        self.doll = [SKSpriteNode spriteNodeWithImageNamed:@"doll.png"];
        self.doll.anchorPoint =CGPointMake(0.5, 0);
        if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
            self.size=CGSizeMake(165, 180+184.5*3/4);
        }else{
            self.size =CGSizeMake(69, 75+ 57*1.35 *3/4);
            float ratio = [MFImageCropper spriteRatio:self.doll];
            self.doll.size = CGSizeMake(57, 57*ratio);
        }
        self.doll.position=CGPointMake(0, 0);
        self.doll.name=@"dollCharacter";
        self.doll.zPosition=0.1;
        [self addChild:self.doll];
        self.position=[self topRandomPosition:parent];
        [self loadSounds];
        self.move = [self createMoveAction:parent];
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
//    self.moveDown = [SKAction moveByX:0 y:-parent.frame.size.height -2*self.size.height duration:3];
    self.moveDown = [SKAction moveTo:CGPointMake(self.position.x, -2*self.size.height) duration:3];
    SKAction * fallingSound = [SKAction runBlock:^{
        [self.dollFalling play];
    }];
    SKAction * moveDown = [SKAction group:@[self.moveDown,fallingSound]];
    SKAction *hitTheGroundSound = [SKAction playSoundFileNamed:@"hit_the_ground.mp3" waitForCompletion:NO];
    SKAction * removeSounds = [SKAction runBlock:^{
        [self.dollFalling stop];
        [self.dollLaught stop];
        [self.dollOuch stop];
        self.dollFalling=nil;
        self.dollLaught=nil;
        self.dollOuch = nil;
    }];
    return [SKAction sequence:@[moveDown, hitTheGroundSound,removeSounds, self.removeNode]];
}

-(void)taped{
    if (!self.isParachuteOpened) {
        [self.dollFalling stop];
        [self removeAllActions];
        NSMutableArray * textures=[[NSMutableArray alloc] init];
        for (int i = 0; i<8; i++) {
            SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"parachute_%d.png",i+1]];
            [textures addObject:texture];
        }
        CGSize parachuteSize ;
        if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
            parachuteSize = CGSizeMake(165, 180);
        }else{
            parachuteSize = CGSizeMake(69, 75);
        }
        SKSpriteNode * parachute = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:parachuteSize];
        //    parachute.position =CGPointMake(0, self.size.height*3/4);
        parachute.anchorPoint = CGPointMake(0.5, 0);
        parachute.position =CGPointMake(0, self.doll.size.height*3/4);
        [self addChild:parachute];
        SKAction *parachuteOpening= [SKAction animateWithTextures:textures timePerFrame:0.05];
        SKAction * laughtSound = [SKAction runBlock:^{
            [self.dollLaught play];
            self.parachuteOpened =YES;
        }];
        
        self.moveDown.speed = self.moveDown.speed/2;
        SKAction *openningGroup = [SKAction group:@[parachuteOpening, laughtSound]];
        [parachute runAction:openningGroup];
        SKAction *moveDown = [SKAction sequence:@[self.moveDown , self.removeNode]];
        [self runAction:moveDown];
    }else{
        [self.dollLaught stop];
        [self.dollOuch play];
    }
    
}

-(CGPoint)topRandomPosition :(SKNode *)parent{
    CGPoint point;
    float randomX = arc4random()% ((int)parent.frame.size.width - (int)self.size.width) + self.size.width/2;
    point = CGPointMake(randomX, parent.frame.size.height);
    return point;
}

#pragma mark - init sound 

-(void)loadSounds{
    dispatch_queue_t soundQueue=dispatch_queue_create("soundQueue", NULL);
    dispatch_async(soundQueue, ^{
    self.dollFalling = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].dollFalling error:nil];
    [self.dollFalling prepareToPlay];
    
    self.dollLaught = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].dollLaught error:nil];
    [self.dollLaught prepareToPlay];
    
    self.dollOuch = [[AVAudioPlayer alloc] initWithData:[MFSounds sharedSound].dollOuch error:nil];
    [self.dollOuch prepareToPlay];
    });
}


@end
