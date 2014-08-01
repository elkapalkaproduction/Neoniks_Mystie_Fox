//
//  MFBug.m
//  Mystie the Fox
//
//  Created by Roman on 28.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFBug.h"
#import "MFImageCropper.h"

@implementation MFBug

-(instancetype) initWithParent:(SKNode*)parent{
    self.particles =[[NSMutableArray alloc] init];
    if (self=[super initWithName:@"bug.png" parent:parent]) {
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
                CGPoint position =CGPointMake(-self.size.width/4 -2, self.size.height/2-18);
                particle.position = position;//[self convertPoint:position toNode:parent];
                particle.zRotation = M_PI_4/2 *i;
                particle.name =@"particle";
                [self addChild:particle];
                [self.particles addObject:particle];
            }
        }
        self.position =[self rightRandomPosition:parent];
        
    }
    return self;
}




-(SKAction *)createMoveAction :(SKNode *)parent{
    UIBezierPath *bezierPath = [self createSinCurve:parent];
    
    SKAction * move = [SKAction followPath:bezierPath.CGPath asOffset:YES orientToPath:NO duration:5];
    move =[move reversedAction];
    SKAction *windSound = [SKAction playSoundFileNamed:@"wind.mp3" waitForCompletion:NO];
    move = [SKAction group:@[move, windSound]];
//    SKAction * remove = [SKAction removeFromParent];
    return [SKAction sequence:@[move,self.removeNode]];
}

-(void)taped{
//    [self removeAllActions];
//    self.name =nil;
    [super taped];
    SKAction * remove = [SKAction removeFromParent];
    for (SKSpriteNode *particle in self.particles) {
        [particle removeAllActions];
        CGFloat rad = particle.zRotation;
        float tang = tan(rad);
        float positionY;
        float positionX;
//        NSLog ( @" %f rad" , rad);
//        if ( (rad < M_PI_4 && rad >0)|| (rad < 2 *M_PI && rad>7*M_PI_4 )) {
            positionY = self.parent.frame.size.height - particle.position.y + particle.size.height/2;
            positionX = tang * positionY;
//        }else if(rad<3*M_PI_4 && rad>M_PI_4 ){
//            positionX = self.parent.frame.size.width - particle.position.x +particle.size.width/2;
//            positionY = tang * positionX;
//        }else if(rad<5*M_PI_4 && rad >3*M_PI_4){
//            positionY = -particle.position.y - particle.size.height/2;
//            positionX  = tang * fabsf(positionY);
//        }else if(rad < 7 *M_PI_4 && rad > 5*M_PI_4){
//            positionX = - particle.position.x -particle.size.width/2;
//            positionY = tang * fabs(positionX);
//        }
        
                 
        particle.name =nil;
        
        SKAction * moveTo = [SKAction moveTo:CGPointMake(positionX, positionY+self.parent.frame.size.height *2.5) duration:3];
        SKAction *rotation = [SKAction rotateToAngle:0 duration:0.5];
        moveTo = [SKAction group:@[moveTo,rotation]];
        SKAction * sequence = [SKAction sequence:@[moveTo , remove]];
        [particle runAction:sequence];
    }
    SKAction * scream = [SKAction playSoundFileNamed:@"scream.mp3" waitForCompletion:NO];
    SKAction *puff =[SKAction playSoundFileNamed:@"puff.mp3" waitForCompletion:NO];
    
    SKAction * moveDown = [SKAction moveByX:-self.size.height/2 y:-self.position.y duration:1];
    
    SKAction * downGroup = [SKAction group:@[scream,moveDown]];
    SKAction *sequence =[SKAction sequence:@[puff, downGroup,remove] ];
    [self runAction:sequence];
}

@end
