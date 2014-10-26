//
//  Pillar.h
//  Pastel
//
//  Created by Jorrie Brettin on 9/27/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Pillar : CCSprite {
    CCSprite *_animatedPillar;
}

@property int colorInt;
@property double speed;

-(void) customAnimation;
-(void) playSFX:(int)sound;


@end
