//
//  Hard.m
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Hard.h"
#import "GameKitHelper.h"


@implementation Hard

-(void) didLoadFromCCB{
    //set game variables
    pillarGap = 75;
    pillarSpeed = 7;
    pillarInterval = 1.2;
    
    self.level = 5;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"HardButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
        
}

-(void) increaseLevel{
    [super increaseLevel];
    pillarSpeed += 2/pillarSpeed;
    [self schedule:@selector(pillarSpawn:) interval:pillarInterval];
}

-(void) collision{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Hard"] < self.score){
        [[NSUserDefaults standardUserDefaults]setInteger:self.score forKey:@"Hard"];
    }
    [[GameKitHelper sharedGameKitHelper] submitScore:(int64_t)self.score category:@"Hard"];
    
    
    if (self.score >= 100)
    {
        GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier:@"Hard"];

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
    
    
    if (self.score >= 200)
    {
        GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier:@"What"];
        
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
