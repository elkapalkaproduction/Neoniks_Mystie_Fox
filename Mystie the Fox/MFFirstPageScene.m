//
//  MFFirstPageScene.m
//  Mystie the Fox
//
//  Created by Roman on 23.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFFirstPageScene.h"
#import "MFLanguage.h"
#import "MFImageCropper.h"
#import "MFCharactersScroller.h"

#import "MFBug.h"
#import "MFDoll.h"
#import "MFDragon.h"
#import "MFGhost.h"
#import "MFUfo.h"
#import "MFMosquito.h"
#import "MFCat.h"
#import "MFCloud.h"

#define ASSET_BY_SCREEN_HEIGHT(regular, longScreen) (([[UIScreen mainScreen] bounds].size.height == 568.0) ? regular : longScreen)

@interface MFFirstPageScene ()
@property (strong,nonatomic) SKSpriteNode * background;
//@property (strong , nonatomic) SKSpriteNode * wings;
@property (strong, nonatomic) SKSpriteNode * siteNode;
@property (strong ,nonatomic) SKSpriteNode * moreNode;

// Fox
@property (strong,nonatomic) SKSpriteNode * foxNode;
@property (strong,nonatomic) SKSpriteNode * eyesNode;
@property (strong ,nonatomic) SKSpriteNode * tailNode;

// Actions

@property (strong, nonatomic) SKAction * eyesBlink;
@property (strong , nonatomic) SKAction *laughter;
@property (nonatomic) BOOL isLaughter;

@property (strong,nonatomic) SKAction * tailRotation;
@property (strong ,nonatomic) MFCharactersScroller *characterScroller;


//Buttons scrolling
@property (nonatomic) BOOL isTapEnd;

@end

@implementation MFFirstPageScene

-(instancetype)initWithSize:(CGSize)size{
    if (self=[super initWithSize:size]) {
        NSString * backgroundName = @"";
        //        NSString * wingsNodeName = @"";
        NSString * siteNodeName = @"";
        NSString * moreNodeName =@"";
        
        NSString * foxNodeName = @"";
        NSString * eyesNodeName = @"";
        NSString * tailNodeName = @"";
        
        NSString *language = [MFLanguage sharedLanguage].language;
        if ([language isEqualToString:@"ru"]) {
            //            backgroundName = @"iPade_startup-screen_rus.png";
            backgroundName = ASSET_BY_SCREEN_HEIGHT(@"page1_background-568h.png", @"page1_background.png");
            siteNodeName = @"site_rus.png";
            moreNodeName = @"more-rus.png";
        }else{
            //            backgroundName = @"iPad_startup-screen_eng.png";
            
            backgroundName = ASSET_BY_SCREEN_HEIGHT(@"page1_background-568h.png", @"page1_background.png");
            siteNodeName = @"site_eng.png";
            moreNodeName = @"more-eng.png";
        }
        //        Background
        
        self.background = [[SKSpriteNode alloc] initWithImageNamed:backgroundName];
        float backgroundRatio = [MFImageCropper spriteRatio:self.background];
        
        //        self.background.size = self.size;
        self.background.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.background];
        
        //        Buttons
        
        self.siteNode = [[SKSpriteNode alloc] initWithImageNamed:siteNodeName];
        float siteNodeRatio = [MFImageCropper spriteRatio:self.siteNode];
        if ([[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad) {
            self.siteNode.size = CGSizeMake(150, 150*siteNodeRatio);
            self.siteNode.position = CGPointMake(CGRectGetMidX(self.frame), 20);
        }else{
            self.siteNode.position = CGPointMake(CGRectGetMidX(self.frame), 40);
        }
        self.siteNode.name=siteNodeName;
        [self addChild:self.siteNode];
        
        self.moreNode =[SKSpriteNode spriteNodeWithImageNamed:moreNodeName];
        float moreNodeRatio = [MFImageCropper spriteRatio:self.moreNode];
        if ([[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad) {
            self.moreNode.size = CGSizeMake(150, 150*moreNodeRatio);
            self.moreNode.position = CGPointMake(CGRectGetMaxX(self.frame) -self.moreNode.size.width/2, CGRectGetMaxY(self.frame) - self.moreNode.size.height/2);
        }else{
            self.moreNode.position = CGPointMake(CGRectGetMaxX(self.frame) -self.moreNode.size.width/2, CGRectGetMaxY(self.frame) - self.moreNode.size.height/2);
        }
        self.moreNode.name =@"more";
        [self addChild:self.moreNode];
        
        //        Fox
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad) {
            
            tailNodeName = @"fox_tail.png";
            self.tailNode =[[SKSpriteNode alloc]initWithImageNamed:tailNodeName];
            float tailRatio= [MFImageCropper spriteRatio:self.tailNode];
            self.tailNode.anchorPoint=CGPointMake(0, 0);
            self.tailNode.size = CGSizeMake(187/2, 187/2*tailRatio);
            self.tailNode.position = CGPointMake(456.5/2 -5  - self.tailNode.size.width/2, 517.5/2 -31 -self.tailNode.size.height/2);
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
            
            
        }else{
            tailNodeName = @"fox_tail.png";
            self.tailNode =[[SKSpriteNode alloc]initWithImageNamed:tailNodeName];
            float tailRatio= [MFImageCropper spriteRatio:self.tailNode];
            self.tailNode.anchorPoint=CGPointMake(0, 0);
            self.tailNode.size = CGSizeMake(413/2, 413/2*tailRatio);
            self.tailNode.position = CGPointMake(1032.5/2 - self.tailNode.size.width/2, self.size.height - 969.5/2 -self.tailNode.size.height/2);
            [self addChild:self.tailNode];
            
            foxNodeName = @"fox_body.png";
            self.foxNode = [[SKSpriteNode alloc] initWithImageNamed:foxNodeName];
            float foxRatio = [MFImageCropper spriteRatio:self.foxNode];
            self.foxNode.size = CGSizeMake(285.5, 285.5*foxRatio);//CGSizeMake(1536/(320/129)/2, 1536/(320/129)/2*foxRatio);//258
            //        self.foxNode.position=CGPointMake(CGRectGetMidX(self.frame), self.size.height/2);
            self.foxNode.position =CGPointMake(642.5/2, self.size.height-1011/2);//CGPointMake(270/2, 223.5);//self.size.height-689/2);//639
            [self addChild:self.foxNode];
            
            eyesNodeName = @"Fox-blinks-frames-01.png";
            self.eyesNode =[[SKSpriteNode alloc] initWithImageNamed:eyesNodeName];
            float eyesRatio = [MFImageCropper spriteRatio:self.eyesNode];
            self.eyesNode.size = CGSizeMake(191.5, 191.5*eyesRatio);
            self.eyesNode.position =CGPointMake(339.5, 585.5);//(425.5+80)/2);//self.size.height- (609.5+18)/2);
            [self addChild:self.eyesNode];
        }
        
        self.foxNode.name=@"fox";
        self.eyesNode.name=@"fox";
        self.tailNode.name=@"tail";
        
        NSMutableArray * laughterArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<22; i++) {
            SKTexture *texture =[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Fox-laughter-frame-%d",i+1]];
            [laughterArray addObject:texture];
            //        [openEyesArray insertObject:texture atIndex:0];
        }
        
        SKAction * laughter = [SKAction animateWithTextures:[laughterArray copy] timePerFrame:0.1377];
        SKAction * laughterSound = [SKAction playSoundFileNamed:@"fox_giggles.mp3" waitForCompletion:YES];
        self.laughter = [SKAction group:@[laughter,laughterSound]];
        
        SKAction * moveTailUp =[SKAction rotateByAngle:M_PI_4 /2 duration:0.30];
        SKAction *moveTailDowm = [SKAction rotateByAngle:-M_PI_4 /2 duration:0.25];
        self.tailRotation =[SKAction sequence:@[moveTailDowm, moveTailUp]];
        
        self.characterScroller = [[MFCharactersScroller alloc] init];
        [self addChild:self.characterScroller];
        
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//            
//            SKSpriteNode * leftArrow = [[SKSpriteNode alloc] initWithImageNamed:@"arrow-left.png"];
//            float arrowRatio = [MFImageCropper spriteRatio:leftArrow];
//            leftArrow.size = CGSizeMake(50/arrowRatio, 50);
//            leftArrow.position = CGPointMake(leftArrow.size.width/2, 80);
//            leftArrow.name =@"leftArrow";
//            [self addChild:leftArrow];
//            
//            SKSpriteNode * rightArrow = [[SKSpriteNode alloc] initWithImageNamed:@"arrow-right.png"];
//            rightArrow.size = CGSizeMake(50/arrowRatio, 50);
//            rightArrow.position = CGPointMake(self.size.width-rightArrow.size.width/2, 80);
//            rightArrow.name = @"rightArrow";
//            [self addChild:rightArrow];
//        }
        
        
        
    }
    
    return self;
}

- (void)didMoveToView:(SKView *)view{
    NSMutableArray * closeEyesArray = [[NSMutableArray alloc] init];
    NSMutableArray * openEyesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<6; i++) {
        SKTexture *texture =[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Fox-blinks-frames-0%d",i+1]];
        [closeEyesArray addObject:texture];
//        [openEyesArray insertObject:texture atIndex:0];
    }
    
    SKAction * closeEyes = [SKAction animateWithTextures:[closeEyesArray copy] timePerFrame:0.07];
//    SKAction * openEyes = [SKAction animateWithTextures:openEyesArray timePerFrame:1];
    SKAction * openEyes = [closeEyes reversedAction];
    SKAction * wait = [SKAction waitForDuration:7];
    SKAction * blink = [SKAction sequence:@[wait, closeEyes, openEyes]];
    self.eyesBlink = [SKAction repeatActionForever:blink];
    [self.eyesNode runAction:self.eyesBlink];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        UIImage * leftArrowImage = [UIImage imageNamed:@"arrow-left.png"];
        UIImageView * leftArrow =[[UIImageView alloc] initWithImage:leftArrowImage];
        float arrowRatio = [MFImageCropper viewRatio:leftArrow];
        leftArrow.frame = CGRectMake(0, self.size.height-80-25, 50/arrowRatio, 50);
        leftArrow.userInteractionEnabled=YES;
        [self.view addSubview:leftArrow];
        UILongPressGestureRecognizer *longPressLeft =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressLeft:)];
        longPressLeft.minimumPressDuration=0;
        [leftArrow addGestureRecognizer:longPressLeft];
        
        UIImage * rightArrowImage = [UIImage imageNamed:@"arrow-right.png"];
        UIImageView * rightArrow =[[UIImageView alloc] initWithImage:rightArrowImage];
        rightArrow.frame = CGRectMake(self.frame.size.width - 50/arrowRatio, self.size.height-80-25, 50/arrowRatio, 50);
        rightArrow.userInteractionEnabled=YES;
        [self.view addSubview:rightArrow];
        UILongPressGestureRecognizer *longPressRight =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressRight:)];
        longPressRight.minimumPressDuration=0;
        [rightArrow addGestureRecognizer:longPressRight];
        
    }
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        NSLog(@" %@ node.name" ,node.name);
//        NSLog (@" %@ point" , NSStringFromCGPoint(location));
        if ([node.name isEqualToString:@"fox"]) {
            if (!self.isLaughter) {
                self.isLaughter=YES;
                [self.eyesNode removeAllActions];
                SKAction *blinkAgain = [SKAction runBlock:^{
                    [self.eyesNode removeAllActions];
                    [self.eyesNode runAction:self.eyesBlink];
                }];
//                SKAction *sequence =[SKAction sequence:@[self.laughter, blinkAgain]];
                [self.eyesNode runAction:self.laughter completion:^{
                    [self.eyesNode runAction:blinkAgain];
                    self.isLaughter = NO;
                }];
            }
            
        }else if([node.name isEqualToString:@"tail"]){
            [node runAction:self.tailRotation];
        }/*else if([node.name isEqualToString:@"leftArrow"]){
            [self.characterScroller scrollToLeftWithComplition:nil];
        }else if([node.name isEqualToString:@"rightArrow"]){
            [self.characterScroller scrollToRightWithComplition:nil];
        }*/
        
        if (![node.name isEqualToString:@"fox"] && ! [node.name isEqualToString:@"tail"] && node.name!=nil) {
            SKAction * playClickSound =[SKAction playSoundFileNamed:@"button_click.mp3" waitForCompletion:NO];
            NSLog(@"%@ rect " ,NSStringFromCGRect(self.characterScroller.maskFrame)) ;
            if (CGRectContainsPoint(self.characterScroller.maskFrame, location)) {
                NSRange range = [node.name rangeOfString:@"button"];
                if (range.location !=NSNotFound) {
                    [self.characterScroller characterButtonPressed:node.name];
                }
            }
            
            MFCharacter *character;
            
            if ([node.name isEqualToString:@"bugCharacter"]) {
                character = (MFBug *)node;
            }else if ([node.name isEqualToString:@"particle"]) {
                character= (MFBug *)node.parent;
            }else if ([node.name isEqualToString:@"dollCharacter"]) {
                character = (MFDoll *)node.parent;
            }else if ([node.name isEqualToString:@"dragonCharacter"]){
                character = (MFDragon *)node.parent;
            }else if ([node.name isEqualToString:@"ghostCharacter"]){
                character = (MFGhost *)node;
            }else if ([node.name isEqualToString:@"ufoCharacter"]){
                character =(MFUfo *)node;
            }else if ([node.name isEqualToString:@"mosquitoCharacter"]){
                character = (MFMosquito *)node.parent;
            }else if ([node.name isEqualToString:@"catCharacter"]){
                character = (MFCat *)node;
            }
            [character taped];
            
            
            
            [self runAction:playClickSound];
        }
        
    }
}

-(void)leftButtonPressed{
    if ( !self.isTapEnd) {
        [self.characterScroller scrollToLeftWithComplition:^{
            SKAction * wait = [SKAction waitForDuration:0.2];
            [self runAction:wait completion:^{
                [self leftButtonPressed];
            }];
            
        }];
    }
}

-(void)rightButtonPressed{
    if (!self.isTapEnd) {
        [self.characterScroller scrollToRightWithComplition:^{
            SKAction * wait = [SKAction waitForDuration:0.2];
            [self runAction:wait completion:^{
                [self rightButtonPressed];
            }];
        }];
    }
}

-(void)longPressLeft:(UIGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.isTapEnd=NO;
        [self leftButtonPressed];
    }else if (gesture.state ==UIGestureRecognizerStateEnded){
        self.isTapEnd=YES;
    }
}

-(void)longPressRight:(UIGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.isTapEnd=NO;
        [self rightButtonPressed];
    }else if (gesture.state ==UIGestureRecognizerStateEnded){
        self.isTapEnd=YES;
    }
}

@end
