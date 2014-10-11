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



@interface MainScene : CCNode <ADBannerViewDelegate>{
    ADBannerView *_adView;
    ADBannerView *_bannerView;
    
    GameScene *gameScene;
    CCButton *_toggleSoundButton,*_easyButton,*_mediumButton,*_hardButton;
    CGFloat screenWidth,screenHeight;
    CCLabelTTF *easy,*easyScore,*medium,*mediumScore,*hard,*hardScore;
}

@end
