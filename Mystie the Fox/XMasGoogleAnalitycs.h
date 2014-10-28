//
//  XMasGoogleAnalitycs.h
//  xmas
//
//  Created by Andrei Vidrasco on 10/7/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *const EVENT_MAIN_APP_STARTED;
NSString *const EVENT_MAIN_WHO_IS_MISTY;
NSString *const EVENT_MAIN_NEONIKS_WEBSITE;
NSString *const EVENT_MAIN_START_CLICKED;
NSString *const EVENT_WHO_IS_MISTY_PLAY;
NSString *const EVENT_WHO_IS_MISTY_MORE;
NSString *const EVENT_PLAY_MORE;
NSString *const EVENT_PLAY_MISTY;
NSString *const EVENT_PLAY_CHAR;
NSString *const EVENT_IN_APP_YES;
NSString *const EVENT_IN_APP_NO;
NSString *const EVENT_VIDEO_YES;
NSString *const EVENT_VIDEO_NO;


@interface XMasGoogleAnalitycs : NSObject

+ (instancetype)sharedManager;
- (void)logEventWithCategory:(NSString *)category
                      action:(NSString *)action
                       label:(NSString *)label
                       value:(NSNumber *)value;

- (void)startLogTime:(NSString *)screenName;
- (void)endLogTime;


@end
