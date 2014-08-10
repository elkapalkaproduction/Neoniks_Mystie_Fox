//
//  MFCharacter.h
//  Mystie the Fox
//
//  Created by Roman on 30.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MFCharacter : SKSpriteNode

@property(strong,nonatomic) SKAction *move;

@property (strong,nonatomic) SKAction * removeNode;

-(instancetype) initWithName:(NSString*)name;

-(instancetype) initWithName:(NSString*)name parent:(SKNode*)parent;

-(instancetype) initWithName:(NSString *)name parent:(SKNode *)parent sizeForIpad:(CGSize)sizeIpad sizeForIphone:(CGSize )sizeIphone;

-(instancetype)initWithParent:(SKNode *) parent;

-(UIBezierPath*)createSinCurve:(SKNode *) parent;

-(SKAction *)createMoveAction :(SKNode *)parent;

-(void)taped;

-(CGPoint)rightRandomPosition:(SKNode *)parent;

-(CGPoint)topRandomPosition:(SKNode *)parent;



@property (nonatomic)BOOL isFadeAway;
-(void)fadeAwaySound;

@end
