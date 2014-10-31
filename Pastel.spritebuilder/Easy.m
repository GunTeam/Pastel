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
