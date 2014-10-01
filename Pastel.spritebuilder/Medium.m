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
    self.level = 4;
    [super didLoadFromCCB];
    CCNode *buttons = [CCBReader load:@"MediumButtons"];
    buttons.position = CGPointMake(screenWidth, 0);
    [self addChild:buttons z:1];
}



@end
