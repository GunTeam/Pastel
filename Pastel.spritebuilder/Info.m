//
//  Info.m
//  Pastel
//
//  Created by Jottie Brerrin on 10/29/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Info.h"


@implementation Info

-(void)Back{
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"MainScene"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionRight duration:.3]];
}

@end
