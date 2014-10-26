//
//  SmallButtonSprite.m
//  Pastel
//
//  Created by Jottie Brerrin on 10/25/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "SmallButtonSprite.h"


@implementation SmallButtonSprite

-(void) didLoadFromCCB{
}

-(void) update:(CCTime)delta{
    if (self.opacity == 0){
        [self removeFromParentAndCleanup:true];
    }
}

-(void)vibe:(float)power{
    [self runAction:[CCActionFadeOut actionWithDuration:power*2]];
    [self runAction:[CCActionScaleBy actionWithDuration:power*2 scale:power+1]];
}

@end
