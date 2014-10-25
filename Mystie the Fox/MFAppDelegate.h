//
//  MFAppDelegate.h
//  Mystie the Fox
//
//  Created by Roman on 20.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef MystieFree
#import <AdColony/AdColony.h>
#endif

@interface MFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UIImageView * splashView;

@end
