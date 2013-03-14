//
//  HelloWorldLayer.m
//  dragTheMagnet
//
//  Created by Sangchan Lee on 13. 3. 4..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        block = [CCSprite spriteWithFile:@"blocks.png"];
        block.position = ccp(size.width /2 , size.height/2);
        [self addChild:block z:2];
        
        self.isTouchEnabled = YES;
        isBlockTouched = NO;

	}
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector]convertToGL:location];
    
    CGFloat halfWidth = block.contentSize.width / 2.0;
    CGFloat halfHeight = block.contentSize.height / 2.0;
    
    if (convertedLocation.x > (block.position.x + halfWidth) || convertedLocation.x < (block.position.x - halfWidth) ||
        convertedLocation.y > (block.position.y + halfHeight) || convertedLocation.y < (block.position.y - halfHeight))  {
        isBlockTouched = NO;
    } else {
        isBlockTouched = YES;
        startLocation = ccp(convertedLocation.x,convertedLocation.y);
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isBlockTouched) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
        
        
        CGPoint newLocation = ccp(convertedLocation.x,convertedLocation.y);
        block.position = newLocation;
        
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isBlockTouched) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
        
        endLocation = ccp(convertedLocation.x,convertedLocation.y);
        
        id move = [CCMoveTo actionWithDuration:2 position:ccp(0,0)];
        [block runAction:move];
        
    }

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
