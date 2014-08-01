//
//  MFBug.h
//  Mystie the Fox
//
//  Created by Roman on 28.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MFCharacter.h"

@interface MFBug : MFCharacter

-(instancetype) initWithParent:(SKNode*)parent;


@property (strong,nonatomic) SKAction *actionOnTap;

@property (strong ,nonatomic) NSMutableArray * particles;

-(void)taped;

@end
