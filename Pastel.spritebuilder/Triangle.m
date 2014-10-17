//
//  Triangle.m
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Triangle.h"


@implementation Triangle

-(void) didLoadFromCCB{
    //declare collsion type and group
    self.physicsBody.collisionGroup = @"Triangle";
    self.physicsBody.collisionType = @"triangle";
    
    self.scale = .55;
    
    _yellow.visible = false;
    _purple.visible = true;
    _blue.visible = false;
    _green.visible = false;
    _red.visible = false;
    self.colorInt = 1;
    
    triArray = @[_yellow,_purple,_blue,_green,_red];
}

-(void) changeColor:(int)newColor{
    if (newColor == 0){
        self.colorInt = 0;
        _yellow.visible = true;
        _purple.visible = false;
        _blue.visible = false;
        _green.visible = false;
        _red.visible = false;
    } else if (newColor == 1) {
        self.colorInt = 1;
        _yellow.visible = false;
        _purple.visible = true;
        _blue.visible = false;
        _green.visible = false;
        _red.visible = false;
    } else if (newColor == 2) {
        self.colorInt = 2;
        _yellow.visible = false;
        _purple.visible = false;
        _blue.visible = true;
        _green.visible = false;
        _red.visible = false;
    } else if (newColor == 3) {
        self.colorInt = 3;
        _yellow.visible = false;
        _purple.visible = false;
        _blue.visible = false;
        _green.visible = true;
        _red.visible = false;
    } else {
        self.colorInt = 4;
        _yellow.visible = false;
        _purple.visible = false;
        _blue.visible = false;
        _green.visible = false;
        _red.visible = true;
    }
}

-(void) triangleCrash:(CCSprite *)triangle{
    triangle.visible = true;
//    [triangle runAction:[CCActionFadeOut actionWithDuration:.5]];
//    [triangle runAction:[CCActionScaleBy actionWithDuration:.5 scale:1.5]];
}

-(void) collision{
    CCLOG(@"Triangle collision was called");
    for (CCSprite *sprite in triArray){
        [self triangleCrash:sprite];
    }
    
    CCActionFadeOut *fade =[CCActionFadeOut actionWithDuration:.5];
    CCActionScaleBy *scale = [CCActionScaleBy actionWithDuration:.7 scale:5];
    CCActionDelay *delay = [CCActionDelay actionWithDuration:.3];
    [_yellow runAction:fade];
    [_yellow runAction:scale];
    [_blue runAction:[CCActionSequence actionWithArray:@[delay,fade]]];
    [_blue runAction:[CCActionSequence actionWithArray:@[delay,scale]]];
    [_green runAction:[CCActionSequence actionWithArray:@[delay,delay,fade]]];
    [_green runAction:[CCActionSequence actionWithArray:@[delay,delay,scale]]];
    [_red runAction:[CCActionSequence actionWithArray:@[delay,delay,delay,fade]]];
    [_red runAction:[CCActionSequence actionWithArray:@[delay,delay,delay,scale]]];
    [_purple runAction:[CCActionSequence actionWithArray:@[delay,delay,delay,delay,fade]]];
    [_purple runAction:[CCActionSequence actionWithArray:@[delay,delay,delay,delay,scale]]];
    
}


@end
