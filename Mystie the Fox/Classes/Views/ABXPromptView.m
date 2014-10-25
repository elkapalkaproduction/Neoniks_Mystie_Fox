//
//  ABXPromptView.m
//  Sample Project
//
//  Created by Stuart Hall on 30/05/2014.
//  Copyright (c) 2014 Appbot. All rights reserved.
//

#import "ABXPromptView.h"
#import "UIImage+Helps.h"
#import "UIButton+Helps.h"
#import "NSString+ABXLocalized.h"

@interface ABXPromptView ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) IBOutlet UIImageView *label;
@property (nonatomic, strong) IBOutlet UIButton *leftButton;
@property (nonatomic, strong) IBOutlet UIButton *rightButton;

@property (nonatomic, assign) BOOL step2;
@property (nonatomic, assign) BOOL liked;

@end

@implementation ABXPromptView


#pragma mark - Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftButton.image = [UIImage imageWithUnlocalizedName:@"prompt_yes"];
    self.rightButton.image = [UIImage imageWithUnlocalizedName:@"prompt_no"];
    self.label.image = [UIImage imageWithUnlocalizedName:@"having_fun"];
    [self.leftButton addTarget:self action:@selector(onLove) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(onImprove) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Buttons

- (void)onLove {
    if (self.step2) {
        if (self.liked && self.delegate && [self.delegate respondsToSelector:@selector(appbotPromptForReview)]) {
            [self.delegate appbotPromptForReview];
        } else if (!self.liked && self.delegate && [self.delegate respondsToSelector:@selector(appbotPromptForFeedback)]) {
            [self.delegate appbotPromptForFeedback];
        }
    } else {
        self.liked = YES;
        self.step2 = YES;
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.leftButton.image = [UIImage imageWithUnlocalizedName:@"alert_love_to"];
                             self.rightButton.image = [UIImage imageWithUnlocalizedName:@"alert_not_now"];
                             self.label.image = [UIImage imageWithUnlocalizedName:@"great"];
                         }];
    }
}


- (void)onImprove {
    if (self.step2) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(appbotPromptClose)]) {
            [self.delegate appbotPromptClose];
        }
    } else {
        self.liked = NO;
        self.step2 = YES;
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.leftButton.image = [UIImage imageWithUnlocalizedName:@"send_feedback"];
                             self.rightButton.image = [UIImage imageWithUnlocalizedName:@"alert_not_now"];
                             self.label.image = [UIImage imageWithUnlocalizedName:@"improve"];
                         }];
    }
}


@end
