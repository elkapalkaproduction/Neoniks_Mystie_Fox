//
//  MFGhost.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFGhost.h"
#import "MFImageCropper.h"

#define ASSET_BY_SCREEN_HEIGHT(longScreen, regular) (([[UIScreen mainScreen] bounds].size.height == 568.0) ? longScreen : regular)

@interface MFGhost ()

@property (nonatomic) BOOL isTapped;

@property (strong,nonatomic) SKAction *ghostFlying;
@property (strong,nonatomic) SKAction *ghostSobbing;
@property (strong, nonatomic) SKAction * ghostHole;

@end

@implementation MFGhost

-(instancetype)initWithParent:(SKNode *)parent{
    [self loadSounds];
    if (self=[super initWithName:@"Ghost-1.png" parent:parent]) {
        self.name=@"ghostCharacter";
        float ratio = [MFImageCropper spriteRatio:self];
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            self.size = CGSizeMake( ASSET_BY_SCREEN_HEIGHT(130, 90), ASSET_BY_SCREEN_HEIGHT(130, 90) *ratio );
        }else{
            self.size =CGSizeMake(200, 200*ratio);
        }
        self.position = [self rightRandomPosition:parent];
        
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:7];
    move =[move reversedAction];
    move = [SKAction group:@[move, self.ghostFlying]];
    return [SKAction sequence:@[move,self.removeNode]];
}

-(void)taped{
    NSMutableArray * textures=[[NSMutableArray alloc] init];
    for (int i = 0; i<6; i++) {
        SKTexture *texture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Ghost-%d.png",i+1]];
        [textures addObject:texture];
    }
    SKAction *holeAction= [SKAction animateWithTextures:textures timePerFrame:0.1];
    if (!self.isTapped) {
        self.isTapped =YES;
        holeAction = [SKAction group:@[holeAction,self.ghostHole]];
        holeAction = [SKAction group:@[holeAction, self.ghostSobbing]];
        [self runAction:holeAction];
    }else{
        holeAction =[holeAction reversedAction];
        self.isTapped =NO;
        holeAction =[SKAction group:@[holeAction,self.ghostHole]];
        SKAction *sequence = [SKAction sequence:@[holeAction , self.ghostFlying]];
        [self runAction:sequence];
    }
    
}

-(void)loadSounds{
    self.ghostFlying = [SKAction playSoundFileNamed:@"ghost.mp3" waitForCompletion:NO];
    self.ghostSobbing = [SKAction playSoundFileNamed:@"sobbing.mp3" waitForCompletion:NO];
    self.ghostHole = [SKAction playSoundFileNamed:@"hole.mp3" waitForCompletion:NO];
}

@end
