//
//  MFCharactersScroller.m
//  Mystie the Fox
//
//  Created by Roman on 24.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFCharactersScroller.h"
#import "MFImageCropper.h"

#import "MFBug.h"
#import "MFDoll.h"
#import "MFDragon.h"
#import "MFGhost.h"
#import "MFUfo.h"
#import "MFMosquito.h"
#import "MFCat.h"
#import "MFCloud.h"

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
            self.position = CGPointMake(768/2,147.5);
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
            self.position = CGPointMake(320/2,80);
            
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
        self.maskFrame = CGRectMake(self.position.x -mask.size.width/2, self.position.y - mask.size.height/2, mask.size.width, mask.size.height );
        self.maskNode=mask;
        self.zPosition =1;
    }
    return self;
}

-(void)scrollToLeftWithComplition:(void(^)())block{
    if (self.currentPosition >0) {
        SKAction * moveToLeft = [SKAction moveByX:60 y:0 duration:0.5];
        SKAction * move =[SKAction runBlock:^{
            for (SKSpriteNode *button in self.buttons) {
                [button runAction:moveToLeft];
            }
        }];
        self.currentPosition=self.currentPosition-1;
        [self runAction:move completion:block];
    }
}

-(void)scrollToRightWithComplition:(void(^)())block{
    if (self.currentPosition <4) {
        SKAction * moveToRight = [SKAction moveByX:-60 y:0 duration:0.5];
        SKAction * move =[SKAction runBlock:^{
            for (SKSpriteNode *button in self.buttons) {
                [button runAction:moveToRight];
            }
        }];
        self.currentPosition=self.currentPosition+1;
        [self runAction:move completion:block];
        
    }
}


#pragma mark - Characters

-(void)characterButtonPressed:(NSString *) name{
    MFCharacter *character;
    if ([name isEqualToString:@"button_0"]) {
        character = [[MFBug alloc] initWithParent:self.parent];
//        [self.parent addChild:bug];
//        [bug runAction:bug.move];
    }else if ([name isEqualToString:@"button_1"]){
        character= [[MFDoll alloc] initWithParent:self.parent];
//        [self.parent addChild:doll];
//        [doll runAction:doll.move];
    }else if ([name isEqualToString:@"button_2"]){
        character = [[MFDragon alloc] initWithParent:self.parent];
//        [self.parent addChild:dragon];
//        [dragon runAction:dragon.move];
    }else if ([name isEqualToString:@"button_3"]){
        character = [[MFGhost alloc] initWithParent:self.parent];
    }else if ([name isEqualToString:@"button_4"]){
        character = [[MFUfo alloc] initWithParent:self.parent];
    }else if ([name isEqualToString:@"button_5"]){
        character = [[MFMosquito alloc] initWithParent:self.parent];
    }else if ([name isEqualToString:@"button_6"]){
        character = [[MFCat alloc] initWithParent:self.parent];
    }
    if (name!=nil&& character!=nil) {
        
        [self.parent addChild:character];
        [character runAction:character.move];
    }
}


@end
