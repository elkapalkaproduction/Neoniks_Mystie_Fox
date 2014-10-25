//
//  MFViewController.m
//  Mystie the Fox
//
//  Created by Roman on 20.07.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFViewController.h"

#import "MFIntroScene.h"
#import "MFFirstPageScene.h"
#import "MFSpecialPage.h"
#import "MFCoverScene.h"

#import "MFAdColony.h"

@implementation MFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;

    
    SKScene *scene;
    scene = [MFIntroScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    
    [skView presentScene:scene];
    
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (BOOL)shouldAutorotate
{
//    return YES;
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
//    } else {
//        return UIInterfaceOrientationMaskAll;
//    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(IBAction)unwindToMain:(UIStoryboardSegue *)segue {
    SKView * skView = (SKView *)self.view;
    SKScene *scene;
    if (self.isNeededToPlay) {
        scene = [MFFirstPageScene sceneWithSize:skView.bounds.size];
        scene.scaleMode =SKSceneScaleModeAspectFill;
        [skView presentScene:scene];
    }
}

-(IBAction)unwindToStart:(UIStoryboardSegue *)segue {
    SKView * skView = (SKView *)self.view;
    if([skView.scene isKindOfClass:[MFFirstPageScene class]]){
        __weak MFFirstPageScene *firstScene = (MFFirstPageScene*)skView.scene;
        [firstScene.leftArrow removeFromSuperview];
        [firstScene.rightArrow removeFromSuperview];
    }
    SKScene *scene;
    scene = [MFCoverScene sceneWithSize:skView.bounds.size];
    scene.scaleMode =SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (segue) {
        if ([segue.identifier isEqualToString:@"specialPageSegue"]) {
            [[MFAdColony sharedAdColony] stopRecording];
            __weak MFSpecialPage * destinationVC= segue.destinationViewController;
            destinationVC.parentVC =self;
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
//    return NO;
}



@end
