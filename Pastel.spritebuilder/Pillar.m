//
//  Pillar.m
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Pillar.h"


@implementation Pillar

-(void) didLoadFromCCB{
    //declare collision type and group
    self.physicsBody.collisionGroup = @"Pillar";
    self.physicsBody.collisionType = @"pillar";
    
}

-(void) update:(CCTime)delta{
    self.positionInPoints = CGPointMake(self.positionInPoints.x - self.speed, self.positionInPoints.y);
    if (self.positionInPoints.x < 0 - self.contentSizeInPoints.width/2){
        [self removeFromParent];
    }
}

@end
