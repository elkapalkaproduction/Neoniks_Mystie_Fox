//
//  XMasGoogleAnalitycs.m
//  xmas
//
//  Created by Andrei Vidrasco on 10/7/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "XMasGoogleAnalitycs.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

NSString *const EVENT_MAIN_APP_STARTED = @"EVENT_MAIN_APP_STARTED";
NSString *const EVENT_MAIN_WHO_IS_MISTY = @"EVENT_MAIN_WHO_IS_MISTY";
NSString *const EVENT_MAIN_NEONIKS_WEBSITE = @"EVENT_MAIN_NEONIKS_WEBSITE";
NSString *const EVENT_MAIN_START_CLICKED = @"EVENT_MAIN_START_CLICKED";
NSString *const EVENT_WHO_IS_MISTY_PLAY = @"EVENT_WHO_IS_MISTY_PLAY";
NSString *const EVENT_WHO_IS_MISTY_MORE = @"EVENT_WHO_IS_MISTY_MORE";
NSString *const EVENT_PLAY_MORE = @"EVENT_PLAY_MORE";
NSString *const EVENT_PLAY_MISTY = @"EVENT_PLAY_MISTY";
NSString *const EVENT_PLAY_CHAR = @"EVENT_PLAY_";
NSString *const EVENT_IN_APP_YES = @"EVENT_IN_APP_YES";
NSString *const EVENT_IN_APP_NO = @"EVENT_IN_APP_NO";
NSString *const EVENT_VIDEO_YES = @"EVENT_VIDEO_YES";
NSString *const EVENT_VIDEO_NO = @"EVENT_VIDEO_NO";

NSString *const GOOGLE_ANALITYCS_TRACKING_ID = @"UA-33114261-6";

@interface XMasGoogleAnalitycs ()
@property (strong, nonatomic) GAIDictionaryBuilder *builder;
@end

@implementation XMasGoogleAnalitycs

+ (instancetype)sharedManager {
    
    static id sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupAnalitycs];
    }
    
    return self;
}


- (void)setupAnalitycs {
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    [[GAI sharedInstance] trackerWithTrackingId:GOOGLE_ANALITYCS_TRACKING_ID];
}


- (void)logEventWithCategory:(NSString *)category
                      action:(NSString *)action
                       label:(NSString *)label
                       value:(NSNumber *)value {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[GAIDictionaryBuilder createEventWithCategory:category
                                                           action:action
                                                            label:label
                                                            value:value] set:@"start" forKey:kGAISessionControl] build]];
}



- (void)startLogTime:(NSString *)screenName {
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    self.builder = [GAIDictionaryBuilder createScreenView];
    [self.builder set:@"start" forKey:kGAISessionControl];
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[self.builder build]];
}

- (void)endLogTime {
    [self.builder set:@"end" forKey:kGAISessionControl];
}

@end
