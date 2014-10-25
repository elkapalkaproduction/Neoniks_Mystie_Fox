//
//  UIImage+Helps.m
//  Neoniks
//
//  Created by Andrei Vidrasco on 5/18/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "UIImage+Helps.h"

#import "MFLanguage.h"

@implementation UIImage (Helpers)

+ (UIImage *)imageWithUnlocalizedName:(NSString *)name {
    if (!name) return nil;
    NSString *language = [MFLanguage sharedLanguage].language;
    if ([language isEqualToString:@"ru"]) {
        NSString *localizedString = [name stringByAppendingString:@"_rus"];
        
        return [UIImage imageWithLocalizedName:localizedString];
    } else {
        NSString *localizedString = [name stringByAppendingString:@"_eng"];
        
        return [UIImage imageWithLocalizedName:localizedString];
    }
}


+ (UIImage *)imageWithLocalizedName:(NSString *)name {
    if (!name) return nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    if (!path)
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:path];
}

@end
