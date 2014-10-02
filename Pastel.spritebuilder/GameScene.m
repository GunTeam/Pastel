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

@implementation GameScene

-(void) didLoadFromCCB{
    _back.exclusiveTouch = false;
    
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [[[CCDirector sharedDirector] view] setMultipleTouchEnabled:YES];

    
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
    triangle.position = CGPointMake(screenWidth/5, screenHeight/2);
    [_physicsNode addChild:triangle];
    self.currentShipColor = 1;
    
    self.score = 0;
    scoreLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%d",self.score] fontName:@"PoiretOne-Regular" fontSize:41];
    scoreLabel.color = [CCColor colorWithCcColor3b:ccBLACK];
    scoreLabel.anchorPoint = CGPointMake(1, 1);
    scoreLabel.position = CGPointMake(screenWidth*22/25, screenHeight);
    [self addChild:scoreLabel z:1];
    
    intendedPosition = screenHeight/2;
    
    [[CCDirector sharedDirector]setDisplayStats:true];

    pillArray = [[NSMutableArray alloc]init];
    startCheckingPillars = false;
    [self schedule:@selector(gatePassCheck:) interval:1/30.];
    
    numPillarsSpawned = 0;
    [self schedule:@selector(pillarSpawn:) interval:pillarInterval];
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

-(void)gatePassCheck:(CCTime)dt{
    if (startCheckingPillars || [pillArray count] > 0){
        Pillar *measuringPillar = [pillArray objectAtIndex:0];
        if ((measuringPillar.position.x-triangle.position.x) < 0){
            [[pillArray objectAtIndex:0] customAnimation];
            [[pillArray objectAtIndex:1] customAnimation];
            
            [pillArray removeObjectAtIndex:0];//remove the first two, which is just two serial calls
            [pillArray removeObjectAtIndex:0];
            
            self.score += 1;
            scoreLabel.string = [NSString stringWithFormat:@"%d",self.score];
            if (self.score % 10 == 0) {
                //do the animation of increasing the speed
                //reschedule the selector
                [self increaseLevel];
            }
        }
    }
}

-(void) increaseLevel{
    //modify the speed and interval of the game
    //speed controlled by pillarSpeed
    //interval controlled by scheduled interval
    //gap controlled by pillarGap
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
    [pillArray addObject:pillar1];
    [pillArray addObject:pillar2];
    numPillarsSpawned += 1;
    if (numPillarsSpawned%10 == 0) {
        [self unschedule:@selector(pillarSpawn:)];
    }
    
//    NSLog([NSString stringWithFormat:@"%d",[pillArray count]]);
    
}

-(void) Back{
    [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"MainScene"]];
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair triangle:(Triangle *)triangle pillar:(Pillar *)pillar{
    CCLOG(@"Collision happened");
    //implement game over animation and storage stuff
    
    return true;
}

@end
