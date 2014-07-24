//
//  MFCharactersScroller.m
//  Mystie the Fox
//
//  Created by Roman on 24.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFCharactersScroller.h"
#import "MFImageCropper.h"

@interface MFCharactersScroller ()

@property (nonatomic) int currentPosition;

@end

@implementation MFCharactersScroller


//-(instancetype) init{
//    if (self = [super init]) {
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//            self.size = CGSizeMake(768, 100);
//            self.position = CGPointMake(768/2,140);
//            for (int i =0; i<8; i++) {
//                SKSpriteNode * button = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"IPad_button_%d.png", i+1]];
//                button.position = CGPointMake(i*button.size.width -self.size.width/2 +button.size.width/2 +2, 0 );
//                button.name =[NSString stringWithFormat:@"button_%d",i];
//                [self addChild:button];
//                [self.buttons addObject:button];
//            }
//        }else{
//            self.size = CGSizeMake(240, 60);
//            self.color = [UIColor greenColor];
//            self.position = CGPointMake(320/2,70);
//            
//            for (int i =0; i<8; i++) {
//                SKSpriteNode * button = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"IPad_button_%d.png", i+1]];
//                button.size=CGSizeMake(60, 60);
//                button.position = CGPointMake(i*button.size.width -self.size.width/2 +button.size.width/2 +2, 0 );
//                button.name =[NSString stringWithFormat:@"button_%d",i];
//                
//                [self addChild:button];
//                [self.buttons addObject:button];
//            }
//        }
//    }
//    return self;
//}

-(instancetype) init{
    if (self = [super init]) {
        self.buttons = [[NSMutableArray alloc] init];
        self.currentPosition=0;
        SKSpriteNode * mask = [[SKSpriteNode alloc] init];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            mask.size = CGSizeMake(768, 100);
            mask.color = [UIColor greenColor];
            self.position = CGPointMake(768/2,140);
            for (int i =0; i<8; i++) {
                SKSpriteNode * button = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"IPad_button_%d.png", i+1]];
                button.position = CGPointMake(i*button.size.width -768/2 +button.size.width/2 +2, 0 );
                button.name =[NSString stringWithFormat:@"button_%d",i];
                
                if (i>3) {
                    button.color = [UIColor blackColor];
                    button.colorBlendFactor=0.6;
                }
                
                [self addChild:button];
                [self.buttons addObject:button];
            }
        }else{
            mask.size = CGSizeMake(240, 60);
            mask.color = [UIColor greenColor];
            self.position = CGPointMake(320/2,70);
            
            for (int i =0; i<8; i++) {
                SKSpriteNode * button = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"IPad_button_%d.png", i+1]];
                button.size=CGSizeMake(60, 60);
                button.position = CGPointMake(i*button.size.width -240/2 +button.size.width/2 +2, 0 );
                button.name =[NSString stringWithFormat:@"button_%d",i];
                
                if (i>3) {
                    button.color = [UIColor blackColor];
                    button.colorBlendFactor=0.6;
                }
                
                [self addChild:button];
                [self.buttons addObject:button];
            }
            
        }
        self.maskNode=mask;
    }
    return self;
}

-(void)scrollToLeft{
    if (self.currentPosition >0) {
        NSMutableArray * action = [[NSMutableArray alloc] init];
        SKAction * moveToLeft = [SKAction moveByX:60 y:0 duration:0.5];
        for (SKSpriteNode *button in self.buttons) {
            [button runAction:moveToLeft];
        }
        self.currentPosition=self.currentPosition-1;
    }
}

-(void)scrollToRight{
    if (self.currentPosition <4) {
        NSMutableArray * action = [[NSMutableArray alloc] init];
        SKAction * moveToRight = [SKAction moveByX:-60 y:0 duration:0.5];
        for (SKSpriteNode *button in self.buttons) {
            [button runAction:moveToRight];
        }
        self.currentPosition=self.currentPosition+1;
    }
}

@end
