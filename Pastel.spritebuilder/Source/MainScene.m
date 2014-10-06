//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene

-(void)didLoadFromCCB{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"ReturningUser"]) {
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"ReturningUser"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Easy"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Medium"];
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Hard"];
    }
}

-(void) Easy {
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Easy"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

-(void) Medium {
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Medium"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

-(void) Hard {
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"Hard"] withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:.3]];
}

@end
