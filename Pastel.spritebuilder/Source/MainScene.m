//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene



//iAd codes
-(id)init
{
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

//end iAd codes

-(void)didLoadFromCCB{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        screenWidth = screenWidth/2;
        screenHeight = screenHeight/2;
    }
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"ReturningUser"]) {
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"ReturningUser"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Easy"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Medium"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Hard"];
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"SFXOn"];
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
    CCLOG(@"SoundToggled");
    [[OALSimpleAudio sharedInstance]setEffectsMuted:![[NSUserDefaults standardUserDefaults]boolForKey:@"SFXOn"]];
    
    [[NSUserDefaults standardUserDefaults]setBool:![[NSUserDefaults standardUserDefaults]boolForKey:@"SFXOn"] forKey:@"SFXOn"];
}

-(void) Easy {
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Easy"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

-(void) Medium {
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Medium"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

-(void) Hard {
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Hard"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

- (void) showGameCenter
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        [self presentViewController: gameCenterController animated: YES completion:nil];
    }
}

@end
