//
//  MFCoverScene.m
//  Mystie the Fox
//
//  Created by Roman on 20.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFCoverScene.h"
#import "MFLanguage.h"
#import "MFImageCropper.h"
#import "MFFirstPageScene.h"

#define ASSET_BY_SCREEN_HEIGHT(regular, longScreen) (([[UIScreen mainScreen] bounds].size.height == 568.0) ? regular : longScreen)

@interface MFCoverScene ()
@property (strong,nonatomic) SKSpriteNode * background;
@property (strong, nonatomic) SKSpriteNode * mystieTheFoxNode;
//@property (strong , nonatomic) SKSpriteNode * wings;
@property (strong,nonatomic) SKSpriteNode * startNode;
@property (strong ,nonatomic) SKSpriteNode * whoIsNode;
@property (strong, nonatomic) SKSpriteNode * siteNode;

// Fox
@property (strong,nonatomic) SKSpriteNode * foxNode;
@property (strong,nonatomic) SKSpriteNode * eyesNode;
@property (strong ,nonatomic) SKSpriteNode * tailNode;

@end

@implementation MFCoverScene

-(instancetype)initWithSize:(CGSize)size{
    if(self=[super initWithSize:size]){
        
        NSString * backgroundName = @"";
        NSString * mystieTheFoxNodeName = @"";
//        NSString * wingsNodeName = @"";
        NSString * startNodeName = @"";
        NSString * whoIsNodeName = @"";
        NSString * siteNodeName = @"";
        
        NSString * foxNodeName = @"";
        NSString * eyesNodeName = @"";
        NSString * tailNodeName = @"";
        
        NSString *language = [MFLanguage sharedLanguage].language;
        if ([language isEqualToString:@"ru"]) {
//            backgroundName = @"iPade_startup-screen_rus.png";
            if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
                backgroundName = @"iPade_startup-screen_rus.png";
            }else{
                backgroundName = ASSET_BY_SCREEN_HEIGHT(@"page1_background-568h.png", @"page1_background.png");
                mystieTheFoxNodeName = @"mystie_the_fox_rus.png";
            }
            startNodeName = @"start-rus.png";
            whoIsNodeName = @"Who-is-Mystie-rus.png";
            siteNodeName = @"site_rus.png";
        }else{
//            backgroundName = @"iPad_startup-screen_eng.png";
            if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
                backgroundName =@"iPad_startup-screen_eng.png";
            }else{
                backgroundName = ASSET_BY_SCREEN_HEIGHT(@"page1_background-568h.png", @"page1_background.png");
                mystieTheFoxNodeName = @"mystie_the_fox_eng.png";
            }
            startNodeName = @"start-eng.png";
            whoIsNodeName =@"Who-is-Mystie-eng.png";
            siteNodeName = @"site_eng.png";
        }
//        Background
        
        self.background = [[SKSpriteNode alloc] initWithImageNamed:backgroundName];
        float backgroundRatio = [MFImageCropper spriteRatio:self.background];

//        self.background.size = self.size;
        self.background.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.background];
        
//        Buttons
        
        self.startNode = [[SKSpriteNode alloc] initWithImageNamed:startNodeName];
        float startRatio = [MFImageCropper spriteRatio:self.startNode];
        if ([[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad) {
            self.startNode.size = CGSizeMake(145.5, 145.5*startRatio);
            self.startNode.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height - 140);
        }else{
            self.startNode.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height - 280);
        }
        self.startNode.name=@"startNode";
        [self addChild:self.startNode];
        
        self.whoIsNode = [[SKSpriteNode alloc] initWithImageNamed:whoIsNodeName];
        float whoIsRatio = [MFImageCropper spriteRatio:self.whoIsNode];
        if ([[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad) {
            self.whoIsNode.size = CGSizeMake(201, 201*whoIsRatio);
            self.whoIsNode.position = CGPointMake(CGRectGetMidX(self.frame), 90);
        }else{
            self.whoIsNode.position = CGPointMake(CGRectGetMidX(self.frame), 130);
        }
        self.whoIsNode.name=@"whoIsNode";
        [self addChild:self.whoIsNode];
        
        self.siteNode = [[SKSpriteNode alloc] initWithImageNamed:siteNodeName];
        float siteNodeRatio = [MFImageCropper spriteRatio:self.siteNode];
        if ([[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad) {
            self.siteNode.size = CGSizeMake(192, 192*siteNodeRatio);
            self.siteNode.position = CGPointMake(CGRectGetMidX(self.frame), 20);
        }else{
            self.siteNode.position = CGPointMake(CGRectGetMidX(self.frame), 40);
        }
        self.siteNode.name=siteNodeName;
        [self addChild:self.siteNode];
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad) {
            self.mystieTheFoxNode = [[SKSpriteNode alloc] initWithImageNamed:mystieTheFoxNodeName];
            float mystieRatio = [MFImageCropper spriteRatio:self.mystieTheFoxNode];
            self.mystieTheFoxNode.size = CGSizeMake(320, 320*mystieRatio);
            self.mystieTheFoxNode.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height- self.mystieTheFoxNode.size.height);
            [self addChild:self.mystieTheFoxNode];
            
//            Fox
            
            tailNodeName = @"fox_tail.png";
            self.tailNode =[[SKSpriteNode alloc]initWithImageNamed:tailNodeName];
            float tailRatio= [MFImageCropper spriteRatio:self.tailNode];
            self.tailNode.size = CGSizeMake(187/2, 187/2*tailRatio);
            self.tailNode.position = CGPointMake(456.5/2 -5, 517.5/2 -31);
            [self addChild:self.tailNode];
            
            foxNodeName = @"fox_body.png";
            self.foxNode = [[SKSpriteNode alloc] initWithImageNamed:foxNodeName];
            float foxRatio = [MFImageCropper spriteRatio:self.foxNode];
            self.foxNode.size = CGSizeMake(129, 129*foxRatio);//258
            //        self.foxNode.position=CGPointMake(CGRectGetMidX(self.frame), self.size.height/2);
            self.foxNode.position =CGPointMake(270/2, 223.5);//self.size.height-689/2);//639
            [self addChild:self.foxNode];
            
            eyesNodeName = @"Fox-blinks-frames-01.png";
            self.eyesNode =[[SKSpriteNode alloc] initWithImageNamed:eyesNodeName];
            float eyesRatio = [MFImageCropper spriteRatio:self.eyesNode];
            self.eyesNode.size = CGSizeMake(173/2, 173/2*eyesRatio);
            self.eyesNode.position =CGPointMake(277.5/2+4, 252.5);//(425.5+80)/2);//self.size.height- (609.5+18)/2);
            [self addChild:self.eyesNode];
            
            
        }
        
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if (node.name !=nil) {
            SKAction * sound = [SKAction playSoundFileNamed:@"button_click.mp3" waitForCompletion:NO];
            if ([node.name isEqualToString:@"startNode"]) {
                SKAction * transitionAction = [SKAction runBlock:^{
                    MFFirstPageScene *firstScene = [[MFFirstPageScene alloc] initWithSize:self.view.bounds.size];
                    [self.view presentScene:firstScene];
                }];
                sound = [SKAction group:@[sound, transitionAction]];
            }
            [self runAction:sound];
        }
    }
    
    
}

@end
