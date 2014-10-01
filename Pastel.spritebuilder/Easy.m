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
    self.level = 3;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"EasyButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
}



@end
