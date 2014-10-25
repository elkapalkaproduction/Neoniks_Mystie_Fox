//
//  MFIntroScene.m
//  Mystie the Fox
//
//  Created by Roman on 20.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFIntroScene.h"
#import "MFLanguage.h"
#import "MFImageCropper.h"
#import "MFCoverScene.h"

@interface MFIntroScene ()

@property (strong,nonatomic) UIImage * introImage;
@property (strong ,nonatomic) SKSpriteNode * introSprite;

@end

@implementation MFIntroScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor=[UIColor blackColor];
        NSString *language = [MFLanguage sharedLanguage].language;
        NSString * logoName = nil;
        if([language isEqualToString:@"ru"]){
            logoName=@"logo_rus.png";
        }else{
            logoName=@"logo_eng.png";
        }
        self.introSprite = [SKSpriteNode spriteNodeWithImageNamed:logoName];
        self.introSprite.alpha =0;
        float spriteRatio = [MFImageCropper spriteRatio:self.introSprite];
        self.introSprite.size =CGSizeMake(self.frame.size.width, self.frame.size.width *spriteRatio);
        self.introSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.introSprite];
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{

    SKAction *wait = [SKAction waitForDuration:1];
    SKAction * fadeIn = [SKAction fadeInWithDuration:1.5];
    SKAction * fadeOut = [SKAction fadeOutWithDuration:1.5];
    SKAction * transitionToCover= [SKAction runBlock:^{
        MFCoverScene *coverScene= [[MFCoverScene alloc] initWithSize:self.view.bounds.size];
        [self.view presentScene:coverScene];
    }];
    SKAction * sequence = [SKAction sequence:@[wait,fadeIn, fadeOut,transitionToCover]];
    
    [self.introSprite runAction:sequence];
}

- (void)recoredScene {
    
}

@end
