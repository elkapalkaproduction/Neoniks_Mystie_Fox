//
//  MFUfo.m
//  Mystie the Fox
//
//  Created by Roman on 29.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFUfo.h"
#import "MFImageCropper.h"

@interface MFUfo ()

@property (nonatomic) BOOL isTapped;

@property (strong,nonatomic) SKAction *ufoFlying;
@property (strong,nonatomic) SKAction *ufoAliens;
@property (strong, nonatomic) SKAction * ufoScreech;

@end

@implementation MFUfo

-(instancetype)initWithParent:(SKNode *)parent{
    [self loadSounds];
    if (self=[super initWithName:@"ufo.png" parent:parent]) {
        self.name=@"ufoCharacter";
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
            self.size = [MFImageCropper sizeWith2xSprite:self];
        }
        self.position = [self rightRandomPosition:parent];
    }
    return self;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:7];
    move =[move reversedAction];
    
    move = [SKAction group:@[move, self.ufoFlying]];
    return [SKAction sequence:@[move,self.removeNode]];
}

-(void)taped{
    if (!self.isTapped) {
        SKAction *zRotation = [SKAction rotateByAngle:-M_PI_4 duration:1];
        self.isTapped =YES;
        SKAction *group = [SKAction group:@[zRotation, self.ufoScreech]];
        SKAction *sequence = [SKAction sequence:@[group , self.ufoAliens]];
        [self runAction:sequence];
    }else{
        SKAction *zRotation = [SKAction rotateByAngle:M_PI_4 duration:1];
        self.isTapped =NO;
        SKAction *group = [SKAction group:@[zRotation, self.ufoScreech]];
        SKAction * sequence = [SKAction sequence:@[group, self.ufoFlying]];
        [self runAction:sequence];
        
    }
    
}

-(void)loadSounds{
    self.ufoFlying = [SKAction playSoundFileNamed:@"ufo.mp3" waitForCompletion:NO];
    self.ufoAliens = [SKAction playSoundFileNamed:@"aliens.mp3" waitForCompletion:NO];
    self.ufoScreech = [SKAction playSoundFileNamed:@"screech.mp3" waitForCompletion:NO];
}

@end
