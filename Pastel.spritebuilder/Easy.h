//
//  Easy.h
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@interface Easy : GameScene {
    int tutorialStep;
    
    CCSprite *_bottomLeft,*_topLeft,*_bottomRight,*_midRight,*_topRight;
    CCLabelTTF *_colorTutLabel,*_posTutLabel;
    CCNodeColor *_touchBox,*_continueLabel;
}

@end
