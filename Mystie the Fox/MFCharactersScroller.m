//
//  MFCharactersScroller.m
//  Mystie the Fox
//
//  Created by Roman on 24.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFCharactersScroller.h"
#import "MFImageCropper.h"
#import "MFLanguage.h"
#import "MFAdColony.h"

#import "MFBug.h"
#import "MFDoll.h"
#import "MFDragon.h"
#import "MFGhost.h"
#import "MFUfo.h"
#import "MFMosquito.h"
#import "MFCat.h"
#import "MFCloud.h"

//#import <AdColony/AdColony.h>
#import "AdColony.h"

@interface MFCharactersScroller ()

@property (nonatomic) int currentPosition;

@end

@implementation MFCharactersScroller


-(instancetype) init{
    if (self = [super init]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        BOOL IAPurchased = [defaults boolForKey:@"IAPurchased"];
        BOOL isVideoWathched = [defaults boolForKey:@"isVideoWatched"];
        
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
                    if (IAPurchased||isVideoWathched) {
                        button.colorBlendFactor=0.0;
                    }else{
                        button.colorBlendFactor=0.6;
                    }
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
                    if (IAPurchased||isVideoWathched) {
                        button.colorBlendFactor=0.0;
                    }else{
                        button.colorBlendFactor=0.6;
                    }
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
    }else if ([name isEqualToString:@"button_1"]){
        character= [[MFDoll alloc] initWithParent:self.parent];
    }else if ([name isEqualToString:@"button_2"]){
        character = [[MFDragon alloc] initWithParent:self.parent];
    }else if ([name isEqualToString:@"button_3"]){
        character = [[MFGhost alloc] initWithParent:self.parent];
//        [AdColony playVideoAdForZone:@"vz16512e0b8a19467b8e"
//                        withDelegate:self
//                    withV4VCPrePopup:NO
//                    andV4VCPostPopup:NO];
    }else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        BOOL IAPurchased = [defaults boolForKey:@"IAPurchased"];
        BOOL isVideoWathched = [defaults boolForKey:@"isVideoWatched"];
        
//        if (IAPurchased||isVideoWathched) {
            if ([name isEqualToString:@"button_4"]){
                character = [[MFUfo alloc] initWithParent:self.parent];
            }else if ([name isEqualToString:@"button_5"]){
                character = [[MFMosquito alloc] initWithParent:self.parent];
            }else if ([name isEqualToString:@"button_6"]){
                character = [[MFCat alloc] initWithParent:self.parent];
            }else if ([name isEqualToString:@"button_7"]){
                character = [[MFCloud alloc] initWithParent:self.parent];
            }
//        }else{
//            NSString *message;
//            NSString *watchVideo;
//            NSString *unlock;
//            NSString *restore;
//            NSString *cancel;
//            NSString *language = [MFLanguage sharedLanguage].language;
//            if([language isEqualToString:@"ru"]){
//                if ([MFAdColony sharedAdColony].isSecondZoneLoaded) {
//                    
//                    message=@"Вы можете просмотреть рекламное видео и разблокировать персонажей на один день или разблокировать их навсегда.";
//                    watchVideo=@"Посмотреть видео";
//                    unlock=@"Разблокировать персонажей";
//                    restore=@"Восстановить";
//                    cancel = @"Отмена";
//                }else{
//                    message=@"Вы можете просмотреть рекламное видео и разблокировать персонажей на один день или разблокировать их навсегда.";
//                    unlock=@"Продолжить";
//                    restore=@"Восстановить";
//                    cancel = @"Отмена";
//                }
//            }else{
//                if ([MFAdColony sharedAdColony].isSecondZoneLoaded) {
//                    message=@"Would you like to watch a video and unlock all characters for one day, or unlock all characters forever?";
//                    watchVideo=@"Watch a video";
//                    unlock=@"Unlock all forever";
//                    restore=@"Restore";
//                    cancel = @"Cancel";
//                }else{
//                    message=@"Would you like to watch a video and unlock all characters for one day, or unlock all characters forever?";
//                    unlock=@"Continue";
//                    restore=@"Restore";
//                    cancel = @"Cancel";
//                }
//            }
//            UIAlertView *alertView;
//            if ([MFAdColony sharedAdColony].isSecondZoneLoaded) {
//                alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:cancel otherButtonTitles:watchVideo,unlock,restore, nil];
//            }else{
//                alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:cancel otherButtonTitles:unlock,restore, nil];
//            }
//            [alertView show];
//        }
    }
if (name!=nil&& character!=nil) {
        
        [self.parent addChild:character];
        [character runAction:character.move];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.numberOfButtons==4) {
        if (buttonIndex==1) {
            [AdColony playVideoAdForZone:@"vz16512e0b8a19467b8e"
                            withDelegate:self
                        withV4VCPrePopup:NO
                        andV4VCPostPopup:NO];
        }
    }
}


@end
