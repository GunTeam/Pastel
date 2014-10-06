//
//  Hard.m
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Hard.h"


@implementation Hard

-(void) didLoadFromCCB{
    //set game variables
    pillarGap = 75;
    pillarSpeed = 5;
    pillarInterval = 1.3;
    
    self.level = 5;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"HardButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
    
    
}

-(void) increaseLevel{
    pillarSpeed += 1/pillarSpeed;
    [self schedule:@selector(pillarSpawn:) interval:pillarInterval];
}

-(void) collision{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Hard"] < self.score){
        [[NSUserDefaults standardUserDefaults]setInteger:self.score forKey:@"Hard"];
    }
    [super collision];
}


@end
