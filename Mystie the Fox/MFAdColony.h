//
//  MFAdColony.h
//  Mystie the Fox
//
//  Created by Roman on 16.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFAdColony : NSObject

+(instancetype) sharedAdColony;

@property(nonatomic)BOOL isFirstZoneLoaded;
@property(nonatomic)BOOL isSecondZoneLoaded;

@property(nonatomic) BOOL isSecondZoneWatched;

@end
