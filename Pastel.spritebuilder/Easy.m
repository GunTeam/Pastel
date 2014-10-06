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
    pillarSpeed = 3.;
    pillarInterval = 1.8;
    
    self.level = 3;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"EasyButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
    
    
}

-(void) increaseLevel{
    pillarSpeed += 1/pillarSpeed;
    [self schedule:@selector(pillarSpawn:) interval:pillarInterval];
}

-(void) collision{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Easy"] < self.score){
        [[NSUserDefaults standardUserDefaults]setInteger:self.score forKey:@"Easy"];
    }
    [super collision];
}

@end
