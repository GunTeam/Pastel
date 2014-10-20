//
//  Triangle.h
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Triangle : CCSprite {
    CCSprite *_blue,*_purple,*_green,*_red,*_yellow;
    NSArray *triArray;
    int bezierSpace;
}

-(void) changeColor:(int)newColor;

@property int colorInt;
@property bool isAlive;
@property bool colorChangeEnabled;

-(void)collision;
-(void)accelerate;

@end
