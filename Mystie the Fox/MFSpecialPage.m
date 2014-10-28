//
//  MFSpecialPage.m
//  Mystie the Fox
//
//  Created by Roman on 13.08.14.
//  Copyright (c) 2014 Roman. All rights reserved.
//

#import "MFSpecialPage.h"
#import "MFLanguage.h"
#import "MFFirstPageScene.h"
#import "MFAdColony.h"
#import "MFIntroScene.h"

#ifdef MystieFree
#import <Chartboost/Chartboost.h>
#define NeoniksBookLink @"neoniks-bookfree://character/mystie"
#else
#define NeoniksBookLink @"neoniks-bookpro://character/mystie"
#import <floopsdk/floopsdk.h>
#endif

#import <AVFoundation/AVFoundation.h>
#import "StoryboardUtils.h"
#import "MFPopUpViewController.h"

extern NSString *const bookAppID;
extern NSString *const showingCounter;
extern const NSInteger showPopUpAfter;

@interface MFSpecialPage ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) AVAudioPlayer *clickSound;

@end

@implementation MFSpecialPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * imageName=@"";
    NSString * moreImageName =@"";
    NSString * playImageName=@"";
    NSString * siteImageName=@"";
    NSString * readBookName=@"";
    
    NSString *language = [MFLanguage sharedLanguage].language;
    if ([language isEqualToString:@"ru"]) {
        imageName=@"iPade_page2-rus.png";
        moreImageName=@"moreSpecial-rus.png";
        playImageName=@"playSpecial-rus.png";
        siteImageName=@"linkSpecial-rus.png";
        readBookName=@"about_button_read_book_rus.png";
    }else{
        imageName=@"iPade_page2-eng.png";
        moreImageName=@"moreSpecial-eng.png";
        playImageName=@"playSpecial-eng.png";
        siteImageName=@"linkSpecial-eng.png";
        readBookName=@"about_button_read_book_eng.png";
    }
    UIImage * image = [UIImage imageNamed:imageName];
    UIImage * playImage = [UIImage imageNamed:playImageName];
    UIImage * moreImage = [UIImage imageNamed:moreImageName];
    UIImage * siteImage = [UIImage imageNamed:siteImageName];
    UIImage * readImage = [UIImage imageNamed:readBookName];
    
    
    CGSize backgroundSize;
    CGRect closeRect;
    float ratio;
    float positionRatio;
    if ([[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad) {
        backgroundSize = CGSizeMake(image.size.width/2.4, image.size.height/2.4);
        closeRect=CGRectMake(self.scrollView.frame.size.width-50, 0, 50, 50);
        ratio=2.4;
        positionRatio=1;
    }else{
        NSInteger scaleFactor = [UIScreen mainScreen].scale == 1.f ? 2 : 1; ;
        backgroundSize=CGSizeMake(image.size.width/scaleFactor, image.size.height/scaleFactor);
        closeRect=CGRectMake(self.scrollView.frame.size.width-50*2.4, 0, 50*2.4, 50*2.4);
        ratio=1;
        positionRatio=2.4;
    }
    
    self.scrollView.contentSize=backgroundSize;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backgroundSize.width,backgroundSize.height)];
    imageView.image=image;
    [self.scrollView addSubview:imageView];
    self.scrollView.bounces=NO;
    
    UIImageView * playImageView = [[UIImageView alloc] initWithImage:playImage];
    playImageView.userInteractionEnabled =YES;
    playImageView.frame = CGRectMake(31*positionRatio, (756*positionRatio-playImageView.frame.size.height/ratio),playImageView.frame.size.width/ratio, playImageView.frame.size.height/ratio);
    [self.scrollView addSubview:playImageView];
    UITapGestureRecognizer * playGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play:)];
    [playImageView addGestureRecognizer:playGesture];
    
    UIImageView * moreImageView = [[UIImageView alloc] initWithImage:moreImage];
    moreImageView.userInteractionEnabled =YES;
    moreImageView.frame = CGRectMake(232*positionRatio, (757*positionRatio-moreImageView.frame.size.height/ratio),moreImageView.frame.size.width/ratio, moreImageView.frame.size.height/ratio);
    [self.scrollView addSubview:moreImageView];
    
    UIImageView *siteImageView = [[UIImageView alloc] initWithImage:siteImage];
    siteImageView.userInteractionEnabled=YES;
    siteImageView.frame =CGRectMake(92*positionRatio, (375*positionRatio-siteImageView.frame.size.height/ratio),siteImageView.frame.size.width/ratio, siteImageView.frame.size.height/ratio);
    [self.scrollView addSubview:siteImageView];
    
    UIButton *readBookImageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, readImage.size.width, readImage.size.height)];
    [readBookImageView setImage:readImage forState:UIControlStateNormal];
    [self.scrollView addSubview:readBookImageView];
    UIImage *iconImage = [UIImage imageNamed:@"about_button_read_book_icon"];
    UIButton *readIconImageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iconImage.size.width, iconImage.size.height)];
    [readIconImageView setImage:iconImage forState:UIControlStateNormal];
    NSInteger customRatio = [[UIDevice currentDevice] userInterfaceIdiom] !=UIUserInterfaceIdiomPad? ratio : [UIScreen mainScreen].scale == 1.f? 2 : 1;
    readIconImageView.frame = CGRectMake(20*positionRatio,
                                         (450*positionRatio - readIconImageView.frame.size.height/customRatio),
                                         readIconImageView.frame.size.width/customRatio,
                                         readIconImageView.frame.size.height/customRatio);
    
    readBookImageView.frame = CGRectMake(32*positionRatio + readIconImageView.frame.size.width / 2,
                                         readIconImageView.frame.origin.y + (readIconImageView.frame.size.height - readBookImageView.frame.size.height/customRatio)/ 2 ,
                                         readBookImageView.frame.size.width/customRatio,
                                         readBookImageView.frame.size.height/customRatio);

    [self.scrollView addSubview:readIconImageView];


    [readBookImageView addTarget:self action:@selector(goToReadBook) forControlEvents:UIControlEventTouchUpInside];
    [readIconImageView addTarget:self action:@selector(goToReadBook) forControlEvents:UIControlEventTouchUpInside];

    
    UITapGestureRecognizer * siteGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSite:)];
    [siteImageView addGestureRecognizer:siteGesture];
    
    UITapGestureRecognizer * moreGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMore:)];
    [moreImageView addGestureRecognizer:moreGesture];
    
    UIButton * closeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame=closeRect;
    closeButton.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:closeButton];
    UITapGestureRecognizer *closeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    closeGesture.delaysTouchesBegan=NO;
    closeGesture.delaysTouchesEnded=NO;
    [closeButton addGestureRecognizer:closeGesture];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)close:(id)object{
    [self click];
    SKView *sceneView = (SKView *)self.parentVC.view;
    MFIntroScene *scene = (MFIntroScene *)sceneView.scene;

    [self dismissViewControllerAnimated:YES completion:^{
        [scene recoredScene];
    }];
}

-(void)play:(id)object{
    [self click];
    [[XMasGoogleAnalitycs sharedManager] logEventWithCategory:NSStringFromClass([self class]) action:EVENT_WHO_IS_MISTY_PLAY label:nil value:nil];
    self.parentVC.isNeededToPlay =YES;
    [self performSegueWithIdentifier:@"unwindToMain" sender:self];
}

-(void)showMore:(id)object{
    [self click];
    [[XMasGoogleAnalitycs sharedManager] logEventWithCategory:NSStringFromClass([self class]) action:EVENT_WHO_IS_MISTY_MORE label:nil value:nil];
#ifdef MystieFree
    [Chartboost showMoreApps:CBLocationHomeScreen];
#else
    [[FloopSdkManager sharedInstance] showParentalGate:^(BOOL success) {
        if (success) {
            [[FloopSdkManager sharedInstance] showCrossPromotionPageWithName:nil completion:nil];
        }
    }];
#endif
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


-(void)click{
    if (!self.clickSound) {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"button_click" ofType:@"mp3"]];
        self.clickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }else{
        self.clickSound.currentTime=0;
    }
    [self.clickSound prepareToPlay];
    [self.clickSound play];
}

-(void)showSite:(id)object{
    [self click];
    NSString *language = [MFLanguage sharedLanguage].language;
    NSURL *url = [NSURL URLWithString:@"http://www.neoniks.com"];
    if ([language isEqualToString:@"ru"]) {
        url = [NSURL URLWithString:@"http://www.neoniki.com"];
    }
#ifdef MystieFree
    [[UIApplication sharedApplication] openURL:url];
#else
    [[FloopSdkManager sharedInstance] showParentalGate:^(BOOL success) {
        if (success) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
#endif
}


- (void)goToReadBookParentGate {
    NSURL *bookAppUrl = [NSURL URLWithString:NeoniksBookLink];
    if ([[UIApplication sharedApplication] canOpenURL:bookAppUrl]) {
        [[UIApplication sharedApplication] openURL:bookAppUrl];
    } else {
        NSURL *bookUrl = [self openStoreToAppWithID:bookAppID];
        [[UIApplication sharedApplication] openURL:bookUrl];
    }
}

- (void)goToReadBook {
#ifdef MystieFree
    [self goToReadBookParentGate];
#else
    [[FloopSdkManager sharedInstance] showParentalGate:^(BOOL success) {
        if (success) {
            [self goToReadBookParentGate];
        }
    }];
#endif
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[XMasGoogleAnalitycs sharedManager] startLogTime:@"who if mystie screen"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:showingCounter] integerValue] >= showPopUpAfter) {
        MFPopUpViewController *popUp = [MFPopUpViewController instantiateFromStoryboard];
        [StoryboardUtils addViewController:popUp onViewController:self belowSubview:nil];
        [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:showingCounter];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[XMasGoogleAnalitycs sharedManager] endLogTime];
}

- (NSURL *)openStoreToAppWithID:(NSString *)appId {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8", appId]];
}

@end
