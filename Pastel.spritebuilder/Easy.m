//
//  Easy.m
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Easy.h"


@implementation Easy

-(void) didLoadFromCCB{
    //set game variables
    pillarGap = 85;
    pillarSpeed = 5;
    pillarInterval = 1.5;
    
    self.level = 3;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"EasyButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
    [self unschedule:@selector(pillarSpawn:)];
    tutorialStep = 2;
    [self tutorial:tutorialStep];
    
    
}

-(void) tutorial:(int)step{
    if (step == 2){
        _bottomRight.visible = false;
        _midRight.visible = false;
        _topRight.visible = false;
        _colorTutLabel.visible = false;
    } else if (step == 1) {
        [_posTutLabel removeFromParent];
        [_bottomLeft removeFromParent];
        [_touchBox removeFromParent];
        [_topLeft removeFromParent];
        _bottomRight.visible = true;
        _midRight.visible = true;
        _topRight.visible = true;
        _colorTutLabel.visible = true;
    } else {
        [_bottomRight removeFromParent];
        [_midRight removeFromParent];
        [_topRight removeFromParent];
        [_colorTutLabel removeFromParent];
        [_continueLabel removeFromParent];
        [self schedule:@selector(pillarSpawn:) interval:pillarInterval];
    }
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    [super touchBegan:touch withEvent:event];
    CGPoint touchLocation = [touch locationInNode:self];
    if (touchLocation.x > screenWidth/6 && touchLocation.x < screenWidth*22/25){
        if (tutorialStep){
            CCLOG(@"tutorial fired");
            tutorialStep--;
            [self tutorial:tutorialStep];
        }
    }
    
}

-(void) increaseLevel{
    [super increaseLevel];
    pillarSpeed += 3/pillarSpeed;
    [self schedule:@selector(pillarSpawn:) interval:pillarInterval];
}

-(void) collision{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Easy"] < self.score){
        [[NSUserDefaults standardUserDefaults]setInteger:self.score forKey:@"Easy"];
    }
    [[GameKitHelper sharedGameKitHelper] submitScore:(int64_t)self.score category:@"Easy"];
    
    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier:@"Easy"];

    if (self.score >= 100)
    {
        CCLOG(@"score is high enough");
        achievement.percentComplete = 100;
        achievement.showsCompletionBanner = true;
        [GKAchievement reportAchievements:@[achievement] withCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 NSLog(@"Error in reporting achievements: %@", error);
             }
         }];
    }

    [super collision];
}


@end
