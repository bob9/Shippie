//
//  LSMyScene.h
//  MyFirstGame
//

//  Copyright (c) 2014 Melissa Pringle. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>


@interface LSMyScene : SKScene

@property(nonatomic, retain)  SKSpriteNode *sprite;
@property (nonatomic, retain) CMMotionManager* motionManager;
@property (strong) CMDeviceMotionHandler motionHandler;


@property (strong, nonatomic) SKLabelNode *labelCounterX;
@property (strong, nonatomic) SKLabelNode *labelCounterY;
@property (strong, nonatomic) SKLabelNode *labelCounterZ;

@property (strong, nonatomic) SKLabelNode *labelYawDegrees;
@property (strong, nonatomic) SKLabelNode *labelPitchDegrees;
@property (strong, nonatomic) SKLabelNode *labelRollDegrees;

@property (strong, nonatomic) SKLabelNode *labelTimer;

@property (strong, nonatomic) NSOperationQueue* queue;



@property (assign, nonatomic) CGPoint currentPoint;
@property (assign, nonatomic) CGPoint previousPoint;
@property (assign, nonatomic) CGFloat pacmanXVelocity;
@property (assign, nonatomic) CGFloat pacmanYVelocity;
@property (assign, nonatomic) CGFloat angle;
@property (assign, nonatomic) CMAcceleration acceleration;
//@property (strong, nonatomic) CMMotionManager  *motionManager;
@property (strong, nonatomic) NSOperationQueue *myQueue;
@property (strong, nonatomic) NSDate *lastUpdateTime;

@property (strong, nonatomic) NSMutableArray *meteors;



@end
