//
//  GameScene.h
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Pillar.h"
#import "Triangle.h"

@interface GameScene : CCNode <CCPhysicsCollisionDelegate>
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    CCPhysicsNode *_physicsNode;
    
    CGFloat intendedPosition;
    
    Triangle *triangle;
}
-(void)didLoadFromCCB;

@property int level;
@property int currentShipColor;

@end
