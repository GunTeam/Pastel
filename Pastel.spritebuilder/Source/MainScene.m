//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import <AVFoundation/AVFoundation.h>

@implementation MainScene

//iAd codes
-(id)init
{
    [[GameKitHelper sharedGameKitHelper] authenticateLocalPlayer];
    if( (self= [super init]) )
    {
        
        // On iOS 6 ADBannerView introduces a new initializer, use it when available.
            if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
                _adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
                
            } else {
                _adView = [[ADBannerView alloc] init];
            }
            _adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierLandscape];
            _adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
            [[[CCDirector sharedDirector]view]addSubview:_adView];
            [_adView setBackgroundColor:[UIColor clearColor]];
            [[[CCDirector sharedDirector]view]addSubview:_adView];
            _adView.delegate = self;
    }
    return self;
}


- (void)layoutAnimated:(BOOL)animated
{
    // As of iOS 6.0, the banner will automatically resize itself based on its width.
    // To support iOS 5.0 however, we continue to set the currentContentSizeIdentifier appropriately.
    CGRect contentFrame = [CCDirector sharedDirector].view.bounds;
    _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    
    
    CGRect bannerFrame = _bannerView.frame;
    if (_bannerView.bannerLoaded) {
        contentFrame.size.height -= _bannerView.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        _bannerView.frame = bannerFrame;
    }];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [self layoutAnimated:YES];

}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [self layoutAnimated:YES];
}

-(void) viewDidDisappear {
    CCLOG(@"View did disappear was called");
    [_bannerView removeFromSuperview];
}

//end iAd codes

//Audio visualizer codes
- (void)configureAudioPlayer {
    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:@"TitleTrack" withExtension:@"mp3"];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    [_audioPlayer setNumberOfLoops:-1];
    [_audioPlayer setMeteringEnabled:YES];
    [_audioPlayer play];
}

-(void)didLoadFromCCB{
    //AudioVisualizer codes
    [self configureAudioPlayer];
    [self schedule:@selector(visualize:) interval:1/15.];
    //end audiovisualizer codes
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        screenWidth = screenWidth/2;
        screenHeight = screenHeight/2;
    }
    _firstTimePrompt.visible = false;
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"ReturningUser"]) {
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"ReturningUser"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Easy"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Medium"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Hard"];
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"SFXOn"];
        _firstTimePrompt.visible = true;

    }
    
    _toggleSoundButton.selected = [[NSUserDefaults standardUserDefaults]boolForKey:@"SFXOn"];
    if (_toggleSoundButton.selected) {
        [_audioPlayer setVolume:0];
    } else {
        [_audioPlayer setVolume:1];
    }
    
    //button labels
    easy = [CCLabelTTF labelWithString:@"Easy" fontName:@"PoiretOne-Regular" fontSize:30];
    easy.position = CGPointMake(_easyButton.position.x*screenWidth, screenHeight*_easyButton.position.y + _easyButton.contentSize.height/6);
    [self addChild:easy z:2];
    
    easyScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",(int)[[NSUserDefaults standardUserDefaults]integerForKey:@"Easy"]] fontName:@"PoiretOne-Regular" fontSize:30];
    easyScore.position = CGPointMake(_easyButton.position.x*screenWidth, screenHeight*_easyButton.position.y - _easyButton.contentSize.height/6);
    [self addChild:easyScore z:2];
    
    medium = [CCLabelTTF labelWithString:@"Medium" fontName:@"PoiretOne-Regular" fontSize:30];
    medium.position = CGPointMake(_mediumButton.position.x*screenWidth, screenHeight*_mediumButton.position.y + _mediumButton.contentSize.height/6);
    [self addChild:medium z:2];
    
    mediumScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",(int)[[NSUserDefaults standardUserDefaults]integerForKey:@"Medium"]] fontName:@"PoiretOne-Regular" fontSize:30];
    mediumScore.position = CGPointMake(_mediumButton.position.x*screenWidth, screenHeight*_mediumButton.position.y - _mediumButton.contentSize.height/6);
    [self addChild:mediumScore z:2];
    
    hard = [CCLabelTTF labelWithString:@"Hard" fontName:@"PoiretOne-Regular" fontSize:30];
    hard.position = CGPointMake(_hardButton.position.x*screenWidth, screenHeight*_hardButton.position.y + _hardButton.contentSize.height/6);
    [self addChild:hard z:2];
    
    hardScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",(int)[[NSUserDefaults standardUserDefaults]integerForKey:@"Hard"]] fontName:@"PoiretOne-Regular" fontSize:30];
    hardScore.position = CGPointMake(_hardButton.position.x*screenWidth, screenHeight*_hardButton.position.y - _hardButton.contentSize.height/6);
    [self addChild:hardScore z:2];
    //end button labels
    
    
}

-(void) ToggleSound{
    [[OALSimpleAudio sharedInstance]setEffectsMuted:![[NSUserDefaults standardUserDefaults]boolForKey:@"SFXOn"]];
    [_audioPlayer setVolume:[[NSUserDefaults standardUserDefaults]boolForKey:@"SFXOn"]];

    
    [[NSUserDefaults standardUserDefaults]setBool:![[NSUserDefaults standardUserDefaults]boolForKey:@"SFXOn"] forKey:@"SFXOn"];
}

-(void) Easy {
    [[OALSimpleAudio sharedInstance] playEffect:@"SingleNote12.mp3"];
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Easy"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

-(void) Medium {
    [[OALSimpleAudio sharedInstance] playEffect:@"SingleNote7.mp3"];
    
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Medium"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

-(void) Hard {
    [[OALSimpleAudio sharedInstance] playEffect:@"SingleNote10.mp3"];

    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Hard"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

-(void) Info {
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Info"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionLeft duration:.3]];
}

-(void) bigButtonPulse:(float)power{
    int whichButton = arc4random()% 3;
    ButtonSprite *pulseButton;
    if (whichButton == 0){
        pulseButton = (ButtonSprite *) [CCBReader load:@"SpriteHard"];
        pulseButton.position = CGPointMake(_hardButton.position.x*screenWidth, _hardButton.position.y*screenHeight);
    } else if (whichButton ==1) {
        pulseButton = (ButtonSprite *) [CCBReader load:@"SpriteMedium"];
        pulseButton.position = CGPointMake(_mediumButton.position.x*screenWidth, _mediumButton.position.y*screenHeight);
    } else {
        pulseButton = (ButtonSprite *) [CCBReader load:@"SpriteEasy"];
        pulseButton.position = CGPointMake(_easyButton.position.x*screenWidth, _easyButton.position.y*screenHeight);
    }
    [pulseButton vibe:power];
    [self addChild:pulseButton z:1];
}

-(void) smallButtonPulse:(float)power{
    int whichButton = arc4random()% 3;
    SmallButtonSprite *pulseButton = (SmallButtonSprite *) [CCBReader load:@"SmallButtonSprite"];
    if (whichButton == 0){
        pulseButton.position = CGPointMake(_infoButton.position.x*screenWidth, _infoButton.position.y*screenHeight);
    } else if (whichButton ==1) {
        pulseButton.position = CGPointMake(_toggleSoundButton.position.x*screenWidth, _toggleSoundButton.position.y*screenHeight);
    } else {
        pulseButton.position = CGPointMake(_highScoreButton.position.x*screenWidth, _highScoreButton.position.y*screenHeight);
    }
    [pulseButton vibe:power];
    [self addChild:pulseButton z:1];
}

- (void)visualize:(CCTime)dt {
    if (_audioPlayer.playing )
    {
        // 2
        [_audioPlayer updateMeters];
        
        // 3
        float power = 1+[_audioPlayer averagePowerForChannel:0]/16;
        if (power > .5){
            power = (power - .5)*2;
            [self bigButtonPulse:power];
        } else if (power > .25){
            [self smallButtonPulse:(power)];
        }
    }
    
}

-(void)highScores{
    if([[GameKitHelper sharedGameKitHelper]userAuthenticated] == TRUE)
    {
        GKGameCenterViewController * leaderboardController = [[GKGameCenterViewController alloc] init];
        
        if (leaderboardController != NULL) {
            leaderboardController.gameCenterDelegate = self;
            
            [[CCDirector sharedDirector] presentViewController:leaderboardController animated:YES completion:nil];
        }
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Authentication failed" message:@"Game Center cannot be accessed. Please make sure you have logged in." delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
