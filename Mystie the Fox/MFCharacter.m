//
//  MFCharacter.m
//  Mystie the Fox
//
//  Created by Roman on 30.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFCharacter.h"


@implementation MFCharacter

//#define kWaveOffsetPhone =50.0f;
static int const kWaveOffsetPhone = 50 ;
static int const kWaveOffsetPad = 240;

-(instancetype) initWithName:(NSString*)name parent:(SKNode*)parent{
    if (self=[super initWithImageNamed:name]) {
        self.removeNode = [SKAction removeFromParent];
        self.move = [self createMoveAction:parent];
    }
    return self;
}


-(UIBezierPath*)createSinCurve:(SKNode *) parent{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    //    CGPoint firstPoint = CGPointMake(0, 0);
    CGPoint firstPoint = CGPointMake((parent.frame.size.width + self.size.width)/3, 0);
    CGPoint secondPoint = CGPointMake((parent.frame.size.width + self.size.width)/3*2, 0);
    CGPoint thirdPoint = CGPointMake(parent.frame.size.width + self.size.width, 0);
    
    CGPoint fistControl =CGPointMake((parent.frame.size.width + self.size.width)/3 /2, 50);
    CGPoint secondControl =CGPointMake((parent.frame.size.width + self.size.width)/3*2 -(parent.frame.size.width+ self.size.width)/3 /2, -50);
    CGPoint thirdControl =CGPointMake((parent.frame.size.width+ self.size.width)-(parent.frame.size.width+ self.size.width)/3 /2, 50);
    
    [bezierPath addQuadCurveToPoint:firstPoint controlPoint:fistControl];
    [bezierPath addQuadCurveToPoint:secondPoint controlPoint:secondControl];
    [bezierPath addQuadCurveToPoint:thirdPoint controlPoint:thirdControl];
    
    
    return bezierPath;
}

-(SKAction *)createMoveAction :(SKNode *)parent{
    return nil;
}

-(void)taped{
    [self removeAllActions];
    self.name =nil;
}

#pragma mark -position

-(CGPoint)rightRandomPosition:(SKNode *)parent{
    CGPoint point;
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        float randomY = arc4random()% ((int)parent.frame.size.height-(310+(int)self.size.height)-kWaveOffsetPhone) +310 +self.size.height/2 +kWaveOffsetPhone/2 ;
        point = CGPointMake(parent.frame.size.width + self.size.width/2, randomY);
    }else{
//        int random =arc4random()% ((int)parent.frame.size.height-(710+(int)self.size.height));// -kWaveOffsetPhone);
        float randomY = arc4random()% ((int)parent.frame.size.height-(710+(int)self.size.height) -kWaveOffsetPhone) +710 +self.size.height/2 +kWaveOffsetPhone/2;
//        NSLog(@"%d random" , random);
        point = CGPointMake(parent.frame.size.width + self.size.width/2, randomY);
    }
    NSLog(@"%@ point " , NSStringFromCGPoint(point));
    return point;
}

-(CGPoint)topRandomPosition :(SKNode *)parent{
    CGPoint point;
    float randomX = arc4random()% ((int)parent.frame.size.width - (int)self.size.width) + self.size.width/2;
    point = CGPointMake(randomX, parent.frame.size.height+self.frame.size.height/2);
    return point;
}

-(int)waveOffset{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        return kWaveOffsetPad;
    }else{
        return kWaveOffsetPhone;
    }
}

@end
