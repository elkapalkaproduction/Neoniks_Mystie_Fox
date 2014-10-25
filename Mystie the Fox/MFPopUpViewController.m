//
//  MFPopUpViewController.m
//  Mystie the Fox
//
//  Created by Andrei Vidrasco on 10/25/14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFPopUpViewController.h"
#import "StoryboardUtils.h"
#import "ABXPromptView.h"
#import "ABX.h"
#ifndef MystieFree
#import <floopsdk/floopsdk.h>
#endif
extern NSString *const mystieAppID;
extern NSString *const mystiePaidAppID;

@interface MFPopUpViewController () <ABXPromptViewDelegate>

@end

@implementation MFPopUpViewController

+ (instancetype)instantiateFromStoryboard {
    MFPopUpViewController *popUp = [[StoryboardUtils storyboard] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    
    return popUp;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupDelegates];
}

- (void)setupDelegates {
    for (ABXPromptView *child in self.childViewControllers) {
        if ([child respondsToSelector:@selector(setDelegate:)]) {
            child.delegate = self;
        }
     }
}

- (void)appbotPromptForReview
{
#ifdef MystieFree
    [ABXAppStore openAppStoreReviewForApp:mystieAppID];
#else
    [[FloopSdkManager sharedInstance] showParentalGate:^(BOOL success) {
        if (success) {
            [ABXAppStore openAppStoreReviewForApp:mystiePaidAppID];
        }
    }];
#endif
    [self.view removeFromSuperview];
}

- (void)appbotPromptForFeedback
{
    [ABXFeedbackViewController showFromController:self placeholder:nil];
    [self.view removeFromSuperview];
}

- (void)appbotPromptClose
{
    [self.view removeFromSuperview];
}

@end
