//
//  MFAppDelegate.h
//  Mystie the Fox
//
//  Created by Roman on 20.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AdColony/AdColony.h>
#import "AdColony.h"

@interface MFAppDelegate : UIResponder <UIApplicationDelegate,AdColonyAdDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UIImageView * splashView;

@end
