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
    pillarSpeed = 4.;
    pillarInterval = 1.6;
    
    self.level = 4;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"MediumButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
    
    
}

-(void) increaseLevel{
    pillarSpeed += 1/pillarSpeed;
    [self schedule:@selector(pillarSpawn:) interval:pillarInterval];
}

-(void) collision{
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"Medium"] < self.score){
        [[NSUserDefaults standardUserDefaults]setInteger:self.score forKey:@"Medium"];
    }
    [super collision];
}


@end
