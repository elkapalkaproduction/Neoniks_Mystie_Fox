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

@end

@implementation MFUfo

-(instancetype)initWithParent:(SKNode *)parent{
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
    if (!self.isTapped) {
        SKAction *zRotation = [SKAction rotateByAngle:-M_PI_4 duration:1];
        self.isTapped =YES;
        [self runAction:zRotation];
    }else{
        SKAction *zRotation = [SKAction rotateByAngle:M_PI_4 duration:1];
        self.isTapped =NO;
        [self runAction:zRotation];
        
    }
    
}

@end
