//
//  MFCharactersScroller.h
//  Mystie the Fox
//
//  Created by Roman on 24.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MFCharactersScroller : SKCropNode

@property (strong,nonatomic) NSMutableArray * buttons;

-(void)scrollToLeftWithComplition:(void(^)())block;

-(void)scrollToRightWithComplition:(void(^)())block;

@end
