//
//  Medium.m
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Medium.h"


@implementation Medium

-(void) didLoadFromCCB{
    //set game variables
    pillarGap = 80;
    pillarSpeed = 6;
    pillarInterval = 1.3;
    
    self.level = 4;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"MediumButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
    
}

-(void) increaseLevel{
    [super increaseLevel];
    pillarSpeed += 3/pillarSpeed;
    [self schedule:@selector(pillarSpawn:) interval:pillarInterval];
}

-(void) collision{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Medium"] < self.score){
        [[NSUserDefaults standardUserDefaults]setInteger:self.score forKey:@"Medium"];
    }
    [[GameKitHelper sharedGameKitHelper] submitScore:(int64_t)self.score category:@"Medium"];

    
    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier:@"Medium"];
    
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
