//
//  MFSounds.h
//  Mystie the Fox
//
//  Created by Roman on 05.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MFSounds : NSObject

+(instancetype) sharedSound;

@property(strong,nonatomic) AVAudioPlayer * dollFalling;
@property(strong,nonatomic) AVAudioPlayer * dollLaught;
@property(strong,nonatomic) AVAudioPlayer * dollOuch;

@end
