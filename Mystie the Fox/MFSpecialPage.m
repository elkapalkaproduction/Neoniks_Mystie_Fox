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
#import "Chartboost.h"
#import <AVFoundation/AVFoundation.h>


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

    NSString *language = [MFLanguage sharedLanguage].language;
    if ([language isEqualToString:@"ru"]) {
        imageName=@"iPade_page2-rus.png";
        moreImageName=@"moreSpecial-rus.png";
        playImageName=@"playSpecial-rus.png";
        siteImageName=@"linkSpecial-rus.png";
    }else{
        imageName=@"iPade_page2-eng.png";
        moreImageName=@"moreSpecial-eng.png";
        playImageName=@"playSpecial-eng.png";
        siteImageName=@"linkSpecial-eng.png";
    }
    UIImage * image = [UIImage imageNamed:imageName];
    UIImage * playImage = [UIImage imageNamed:playImageName];
    UIImage * moreImage = [UIImage imageNamed:moreImageName];
    UIImage * siteImage = [UIImage imageNamed:siteImageName];
    
    
    
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
        backgroundSize=image.size;
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
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)play:(id)object{
    [self click];
    self.parentVC.isNeededToPlay =YES;
    [self performSegueWithIdentifier:@"unwindToMain" sender:self];
}

-(void)showMore:(id)object{
    [self click];
    [[Chartboost sharedChartboost] showMoreApps:CBLocationHomeScreen];
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
    if ([language isEqualToString:@"ru"]) {
        NSURL *url = [NSURL URLWithString:@"http://www.neoniki.com"];
        [[UIApplication sharedApplication] openURL:url];
    }else{
        NSURL *url = [NSURL URLWithString:@"http://www.neoniks.com"];
        [[UIApplication sharedApplication] openURL:url];
    }
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

@end
