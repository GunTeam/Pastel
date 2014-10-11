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
    double pillarGap;
    double pillarSpeed;
    double pillarInterval;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    CCPhysicsNode *_physicsNode;
    
    CGFloat intendedPosition;
    
    Triangle *triangle;
    
    NSMutableArray *pillArray;
    
    BOOL startCheckingPillars;
    
    CCLabelTTF *scoreLabel;
    
    int numPillarsSpawned;
    
    CCButton *_back;
}
-(void)didLoadFromCCB;
-(void)collision;

@property int level;
@property int currentShipColor;
@property int score;

@end
