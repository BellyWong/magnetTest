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
        [self schedule:@selector(gameLogic:) interval:2/60 ];

	}
	return self;
}

-(void)gameLogic:(ccTime)dt {
    now = dt;
    block.position = ccp(block.position.x+blockMovement.x,block.position.y+blockMovement.y);
    if (block.position.x > 288 || block.position.x  < 32) {
        blockMovement.x = -blockMovement.x;
        blockMovement.x /= 2;
    }
    if (block.position.x > 288) {
        block.position = ccp(288,block.position.y);
    }
    if (block.position.x < 32) {
        block.position = ccp(32,block.position.y);
    }
    
    if (block.position.y > 448 || block.position.y < 32) {
        blockMovement.y = -blockMovement.y;
        blockMovement.y /= 2;
    }
    if (block.position.y > 448) {
        block.position = ccp(block.position.x, 448);
    }
    if (block.position.y < 32) {
        block.position = ccp(block.position.x, 32);
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch begin");
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
        startTime = now;
        NSLog(@"startTime = %f",startTime);
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isBlockTouched) return ;
    
    //NSLog(@"touch move");
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
    CGPoint newLocation = ccp(convertedLocation.x,convertedLocation.y);
    block.position = newLocation;
        
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isBlockTouched) return ;
    
    NSLog(@"touch end");
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
        
    endLocation = ccp(convertedLocation.x,convertedLocation.y);
    endTime = now;
    NSLog(@"endTime = %f",endTime);
    
    CGPoint deltaDistance = ccp(endLocation.x - startLocation.x , endLocation.y - startLocation.y);
    int deltaTime = (endTime - startTime)*100000;
    if (deltaTime == 0) {
        deltaTime = 1;
    }
    else if (deltaTime < 0 ) {
        deltaTime = -deltaTime;
    }
    NSLog(@"deltaDistance x= %f, y= %f",deltaDistance.x,deltaDistance.y);
    NSLog(@"deltaTime = %d",deltaTime);
    blockMovement = ccp(deltaDistance.x / deltaTime, deltaDistance.y / deltaTime);
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
