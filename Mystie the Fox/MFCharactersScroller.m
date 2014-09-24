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

#import "MKStoreManager.h"

#ifdef MystieFree
#import "AdColony.h"
#import "MFAdColony.h"
#endif

@interface MFCharactersScroller ()

@property (nonatomic) int currentPosition;

@property (strong,nonatomic) NSMutableArray * arrayWithProducts;

@property(strong,nonatomic) UIAlertView *alertView;

@end

@implementation MFCharactersScroller


-(instancetype) init{
    if (self = [super init]) {
#ifdef MystieFree
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        BOOL IAPurchased = [defaults boolForKey:@"IAPurchased"];
        //        BOOL isVideoWathched = [defaults boolForKey:@"isVideoWatched"];
        
        NSDate *expireDate =[defaults objectForKey:@"expireDate"];
        NSDate *now = [NSDate date];
        NSComparisonResult result=[expireDate compare:now];
#endif
        
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
#ifdef MystieFree
                    if (IAPurchased||(result==NSOrderedDescending)) {
                        button.colorBlendFactor=0.0;
                    }else{
                        button.colorBlendFactor=0.6;
                    }
#else
                    button.colorBlendFactor=0.0;
#endif
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
#ifdef MystieFree
                    if (IAPurchased||(result==NSOrderedDescending)) {
                        button.colorBlendFactor=0.0;
                    }else{
                        button.colorBlendFactor=0.6;
                    }
#else
                    button.colorBlendFactor=0.0;
#endif
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
#ifdef MystieFree
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *expireDate =[defaults objectForKey:@"expireDate"];
    NSDate *now = [NSDate date];
    NSComparisonResult result=[expireDate compare:now];
    
    BOOL IAPurchased = [defaults boolForKey:@"IAPurchased"];
#endif
    //    BOOL isVideoWathched = [defaults boolForKey:@"isVideoWatched"];
    [[MFAdColony sharedAdColony] logEvent:[NSString stringWithFormat:@"%@%@", EVENT_PLAY_CHAR, [name stringByReplacingOccurrencesOfString:@"button_" withString:@"CHAR_"]]];
    if ([name isEqualToString:@"button_0"]) {
        character = [[MFBug alloc] initWithParent:self.parent];
    }else if ([name isEqualToString:@"button_1"]){
        character= [[MFDoll alloc] initWithParent:self.parent];
    }else if ([name isEqualToString:@"button_2"]){
        character = [[MFDragon alloc] initWithParent:self.parent];
    }else if ([name isEqualToString:@"button_3"]){
        character = [[MFGhost alloc] initWithParent:self.parent];
    }else {
#ifdef MystieFree
        if (IAPurchased||(result==NSOrderedDescending)) {
#endif
            if ([name isEqualToString:@"button_4"]){
                character = [[MFUfo alloc] initWithParent:self.parent];
            }else if ([name isEqualToString:@"button_5"]){
                character = [[MFMosquito alloc] initWithParent:self.parent];
            }else if ([name isEqualToString:@"button_6"]){
                character = [[MFCat alloc] initWithParent:self.parent];
            }else if ([name isEqualToString:@"button_7"]){
                character = [[MFCloud alloc] initWithParent:self.parent];
            }
#ifdef MystieFree
        }else{
            NSString *message;
            NSString *restore;
            NSString *yesButton;
            NSString *noButton;
            NSString *language = [MFLanguage sharedLanguage].language;
            if([language isEqualToString:@"ru"]){
                yesButton = @"Да";
                noButton = @"Нет";
                restore = @"Восстановить";
                message = @"Октрыть всех персонажей на всегда за $0.99?";
            } else {
                yesButton = @"Yes";
                noButton = @"No";
                restore = @"Restore";
                message = @"Unlock all characters forever for $0.99?";
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:restore otherButtonTitles:yesButton, noButton, nil];
            alert.tag = 1043;
            [alert show];
        }
#endif
    }
    if (name!=nil&& character!=nil) {
        
        [self.parent addChild:character];
        [character runAction:character.move];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1043) {
        [self inAppAlertViewAnalizeWithButtonPressed:buttonIndex];
        return;
    }
    if (alertView.tag == 1533) {
        [self adColonyUnlockAlertWithButtonPressed:buttonIndex];
        return;
    }
    if (alertView ==self.alertView) {
        if (alertView.numberOfButtons==4) {
            if (buttonIndex==1) {
#ifdef MystieFree
                [AdColony playVideoAdForZone:@"vz16512e0b8a19467b8e"
                                withDelegate:self.parent
                            withV4VCPrePopup:NO
                            andV4VCPostPopup:NO];
#endif
            }else if (buttonIndex==2){
                [self buy];
            }else if(buttonIndex ==3){
                [self recover];
            }
        }else{
            if (buttonIndex==1) {
                [self buy];
            }else if(buttonIndex ==2){
                [self recover];
            }
        }
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MFIAPPurchased" object:nil];
    }
}

- (void)inAppAlertViewAnalizeWithButtonPressed:(NSInteger)buttonIndex {
    if (buttonIndex == 2) {
        [[MFAdColony sharedAdColony] logEvent:EVENT_IN_APP_NO];
#ifdef MystieFree
        NSString *message;
        NSString *yesButton;
        NSString *noButton;
        NSString *language = [MFLanguage sharedLanguage].language;
        if([language isEqualToString:@"ru"]){
            yesButton = @"Да";
            noButton = @"Нет";
            message = @"Просмотреть рекламное видео и разблокировать персонажей на один день?";
        } else {
            yesButton = @"Yes";
            noButton = @"No";
            message = @"You can unlock all the characters for one day by watching this video:";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:noButton otherButtonTitles:yesButton, nil];
        alert.tag = 1533;
        if ([MFAdColony sharedAdColony].isSecondZoneLoaded) {
            [alert show];
        }
#endif
    } else if (buttonIndex==1) {
        [[MFAdColony sharedAdColony] logEvent:EVENT_IN_APP_YES];
        [self buy];
    }else if (buttonIndex ==0) {
        [self recover];
    }
}


- (void)adColonyUnlockAlertWithButtonPressed:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[MFAdColony sharedAdColony] logEvent:EVENT_VIDEO_YES];
#ifdef MystieFree
        [AdColony playVideoAdForZone:@"vz16512e0b8a19467b8e"
                        withDelegate:self.parent
                    withV4VCPrePopup:NO
                    andV4VCPostPopup:NO];
#endif
    } else if (buttonIndex == 0) {
        [[MFAdColony sharedAdColony] logEvent:EVENT_VIDEO_NO];

    }
}


-(void)recover{
    self.arrayWithProducts=[MKStoreManager sharedManager].purchasableObjects;
    UIAlertView * alertForSucces = [[UIAlertView alloc] initWithTitle:@"Восстановление завершено" message:@"Восстановление завершено. Приятного использования" delegate:self cancelButtonTitle:@"Спасибо" otherButtonTitles:nil, nil];
    [[MKStoreManager sharedManager] restorePreviousTransactionsOnComplete:^{
        for (SKProduct *product in self.arrayWithProducts){
            if([MKStoreManager isFeaturePurchased:product.productIdentifier]){
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setBool:YES forKey:@"IAPurchased"];
                [defaults synchronize];
            }
        }
        [alertForSucces show];
    }onError:^(NSError *error){
        {
            NSLog(@"%ld code" , (long)error.code );
            NSDictionary *dictWithUserInfo = error.userInfo;
            NSLog(@"%@ user info" , dictWithUserInfo[NSLocalizedDescriptionKey]);
            UIAlertView * alertForError = [[UIAlertView alloc] initWithTitle:@"У вас нет покупок" message:@"Купите что-нибудь" delegate:self cancelButtonTitle:@"Спасибо" otherButtonTitles:nil, nil];
            [alertForError show];
        }
        
    }];
}

-(void)buy{
    self.arrayWithProducts=[MKStoreManager sharedManager].purchasableObjects;
    [[MKStoreManager sharedManager] buyFeature:((SKProduct*)[self.arrayWithProducts firstObject]).productIdentifier onComplete:^(NSString *purchasedFeature, NSData *purchasedReceipt) {
        NSLog(@"Purchased: %@", purchasedFeature);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setBool:YES forKey:@"IAPurchased"];
        [defaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MFIAPPurchased" object:nil];
    } onCancelled:^{
        NSLog(@"User Cancelled Transaction");
        if([MFAdColony sharedAdColony].isThirdZoneLaoded){
            [[MFAdColony sharedAdColony] playAdColonyVidioWithParent:[((SKScene*)self.parent).view nextResponder] zone:@"vz38df8ea2870f41d48e"];
        }else if ([MFAdColony sharedAdColony].isInterstitialRequestLoaded) {
            [[MFAdColony sharedAdColony] showGADInterstitialWithParent:[((SKScene *)self.parent).view nextResponder]];
        }
    }];
}

@end
