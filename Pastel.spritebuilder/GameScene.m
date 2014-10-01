//
//  GameScene.m
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

//To do
//check the screen size and send the pillars at a different speed/interval accordingly

#import "GameScene.h"

double pillarGap = 75;
double pillarSpeed = 5;

@implementation GameScene

-(void) didLoadFromCCB{
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    //add the physics node behind the gamescene buttons
    _physicsNode = [[CCPhysicsNode alloc]init];
    [self addChild:_physicsNode z:1];
    _physicsNode.collisionDelegate = self;
//    _physicsNode.debugDraw = true;
    
    triangle = (Triangle *)[CCBReader load:@"Triangle"];
    triangle.position = CGPointMake(screenWidth/6, screenHeight/2);
    [_physicsNode addChild:triangle];
    self.currentShipColor = 1;
    
    CCLabelTTF *titleLabel = [[CCLabelTTF alloc]initWithString:@"123" fontName:@"PoiretOne-Regular" fontSize:41];
    titleLabel.color = [CCColor colorWithCcColor3b:ccBLACK];
    titleLabel.anchorPoint = CGPointMake(1, 1);
    titleLabel.position = CGPointMake(screenWidth*22/25, screenHeight);
    [self addChild:titleLabel z:1];
    
    intendedPosition = screenHeight/2;
    
    [[CCDirector sharedDirector]setDisplayStats:true];
    
    [self schedule:@selector(pillarSpawn:) interval:.9];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [touch locationInNode:self];
    if (touchLocation.x < screenWidth/6){
        intendedPosition = touchLocation.y;
    } else if (touchLocation.x > screenWidth*22/25){
        [self changeShipColor:touchLocation.y];
    }
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [touch locationInNode:self];
    if (touchLocation.x < screenWidth/6){
        intendedPosition = touchLocation.y;
    } else if (touchLocation.x > screenWidth*22/25){
        [self changeShipColor:touchLocation.y];
    }
}

-(void)update:(CCTime)delta{
    if (intendedPosition != triangle.position.y) {
        triangle.rotation = (triangle.position.y - intendedPosition)*.3;
        triangle.position = CGPointMake(triangle.position.x, triangle.position.y - (triangle.position.y - intendedPosition)*.3);
    }
    
}

-(void) changeShipColor:(CGFloat)touchPosition{
    int desiredShipColor = (int)touchPosition/(screenHeight/self.level);
    if (self.currentShipColor != desiredShipColor){
        self.currentShipColor = desiredShipColor;
        [triangle changeColor:desiredShipColor];
    }
}

-(void) pillarSpawn:(CCTime)dt{
    int pillarColor = arc4random()%self.level;
    Pillar *pillar1;
    Pillar *pillar2;
    if (pillarColor == 0) {
        pillar1 = (Pillar *)[CCBReader load:@"PillarYellow"];
        pillar1.colorInt = 0;
        pillar2 = (Pillar *)[CCBReader load:@"PillarYellow"];
        pillar2.colorInt = 0;
    } else if (pillarColor == 1){
        pillar1 = (Pillar *)[CCBReader load:@"PillarPurple"];
        pillar1.colorInt = 1;
        pillar2 = (Pillar *)[CCBReader load:@"PillarPurple"];
        pillar2.colorInt = 1;
    } else if (pillarColor == 2) {
        pillar1 = (Pillar *)[CCBReader load:@"PillarBlue"];
        pillar1.colorInt = 2;
        pillar2 = (Pillar *)[CCBReader load:@"PillarBlue"];
        pillar2.colorInt = 2;
    } else if (pillarColor == 3) {
        pillar1 = (Pillar *)[CCBReader load:@"PillarGreen"];
        pillar1.colorInt = 3;
        pillar2 = (Pillar *)[CCBReader load:@"PillarGreen"];
        pillar2.colorInt = 3;
    } else {
        pillar1 = (Pillar *)[CCBReader load:@"PillarRed"];
        pillar1.colorInt = 4;
        pillar2 = (Pillar *)[CCBReader load:@"PillarRed"];
        pillar2.colorInt = 4;
    }
    
    int pillarHeight = rand() %  (int)(screenHeight - pillarGap);
    pillar1.position = CGPointMake(screenWidth, pillarHeight);
    pillar2.position = CGPointMake(screenWidth, pillarHeight+pillar1.contentSizeInPoints.height+pillarGap);
    pillar1.speed = pillarSpeed;
    pillar2.speed = pillarSpeed;
    [_physicsNode addChild:pillar1];
    [_physicsNode addChild:pillar2];
    
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair triangle:(Triangle *)triangle pillar:(Pillar *)pillar{
    CCLOG(@"Collision happened");
    //implement game over animation and storage stuff
    
    return true;
}

@end
