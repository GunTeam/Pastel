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
    
    triArray = @[_yellow,_red,_green,_purple,_blue];
    
    bezierSpace = 0;
    self.colorChangeEnabled = true;
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
    int rotationAngle = arc4random() % 720 - 360;
    int yAmp = arc4random() % 30 + 60;
    int xAmp = arc4random() % 15 + 40;
    for (CCSprite *sprite in triArray){
        [self triangleCrash:sprite];
        [sprite runAction:[CCActionRotateBy actionWithDuration:1 angle:rotationAngle]];
        [sprite runAction:[CCActionFadeOut actionWithDuration:1]];
        [sprite runAction:[CCActionMoveBy actionWithDuration:1 position:CGPointMake(cos(rand())*xAmp, sin(rand())*yAmp)]];
        rotationAngle = -rotationAngle + .5*rotationAngle;
        xAmp = xAmp*1.2;
        yAmp = yAmp*1.25;
    }
}

-(void) accelerate{
    int bezierMultiplier = 4;
    bezierSpace +=10;
    for (CCSprite *sprite in triArray){
        [self triangleCrash:sprite];
        ccBezierConfig bezier;
        bezier.controlPoint_1 = ccp(bezierMultiplier*bezierSpace,0);
        bezier.controlPoint_2 = ccp((bezierMultiplier-1)*bezierSpace, 0);
        bezier.endPosition = ccp(0, 0);
        CCActionBezierBy *bezierPath = [CCActionBezierBy actionWithDuration:1.3 bezier:bezier];
        [sprite runAction:bezierPath];
        bezierMultiplier--;
    }
}


@end
