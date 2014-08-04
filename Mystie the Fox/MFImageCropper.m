//
//  MFImageCropper.m
//  Mystie the Fox
//
//  Created by Roman on 20.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFImageCropper.h"

@implementation MFImageCropper

+(float)spriteRatio:(SKSpriteNode *)node{
    float ratio=0;
    ratio = node.size.height / node.size.width;
    return ratio;
}

+(float) viewRatio:(UIView *)view{
    float ratio=0;
    ratio = view.frame.size.height / view.frame.size.width;
    return ratio;
}

+(CGSize ) sizeWith2xSprite:(SKSpriteNode *)node{
    CGSize size;
    float ratio = [self spriteRatio:node];
    size = CGSizeMake(node.size.width / 2.4, node.size.width / 2.4 *ratio);
    
    return size;
}

@end
