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
    self.level = 5;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"HardButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
}



@end
