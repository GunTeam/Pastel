//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "GameScene.h"
#import <iAd/iAd.h>
#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>
#import "ButtonSprite.h"
#import "SmallButtonSprite.h"
#import "AppDelegate.h"



@interface MainScene : CCNode <ADBannerViewDelegate,GKGameCenterControllerDelegate>{
    ADBannerView *_adView;
    ADBannerView *_bannerView;
    
    GameScene *gameScene;
    CCButton *_easyButton,*_mediumButton,*_hardButton;
    CGFloat screenWidth,screenHeight;
    CCLabelTTF *easy,*easyScore,*medium,*mediumScore,*hard,*hardScore;
    CCButton *_toggleSoundButton,*_infoButton,*_highScoreButton;
}

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;


@end
