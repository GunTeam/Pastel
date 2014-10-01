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


@end
