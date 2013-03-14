//
//  HelloWorldLayer.h
//  dragTheMagnet
//
//  Created by Sangchan Lee on 13. 3. 4..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCNode *block, *magnet;
    BOOL isBlockTouched, onMagnetField;
    CGPoint startLocation,endLocation, blockMovement;
    ccTime startTime, endTime, now;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
