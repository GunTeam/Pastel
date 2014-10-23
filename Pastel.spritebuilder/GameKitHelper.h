//
//  GameKitHelper.h
//  Pastel
//
//  Created by Jottie Brerrin on 10/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol GameKitHelperProtocol<NSObject>
@end

//   Protocol to notify external
//   objects when Game Center events occur or
//   when Game Center async tasks are completed
@interface GameKitHelper : NSObject

@property (nonatomic, assign)
id<GameKitHelperProtocol> delegate;

// This property holds the last known error
// that occured while using the Game Center API's
@property (nonatomic, readonly) NSError* lastError;

+ (id) sharedGameKitHelper;

// Player authentication, info
-(void) authenticateLocalPlayer;
@end