//
//  LSMyScene.m
//  MyFirstGame
//
//  Created by Melissa Pringle on 20/03/2014.
//  Copyright (c) 2014 Melissa Pringle. All rights reserved.
//

#import "LSMyScene.h"

@implementation LSMyScene


#define degrees(x) (180 * x / M_PI)

#define kUpdateInterval (1.0f / 60.0f)


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"MH370!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        
        
        [myLabel runAction:[SKAction scaleTo:0.0 duration:1]];
        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:3];
        
//        [myLabel runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:myLabel];
        
        [myLabel  runAction:[SKAction fadeAlphaTo:0 duration:2] completion:^(void)
         {
             [self config];
             [self AddShip];

//             [self startGyro];
         }];
        

        
        
    }
    return self;
}



int y = 5;

-(void) AddMetors
{
    
    if(!self.meteors)
    {
        self.meteors = [[NSMutableArray alloc] init];
    }

    SKSpriteNode* met  = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    
    
    y = y + 5;
    
    met.position = CGPointMake(random() % 360,
                               random() % 568);
    
    met.scale = 0.01;
    [self addChild:met];
    

    
    //move the ship using Sprite Kit's Physics Engine
    //1
    met.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.sprite.frame.size];
    
    //2
    met.physicsBody.dynamic = YES;
    
    //3
    met.physicsBody.affectedByGravity = NO;
    
    //4
    met.physicsBody.mass = 100.0;
    
    met.physicsBody.collisionBitMask = 0;
    met.physicsBody.contactTestBitMask = 0;
    
    
    SKAction *actionAddMonster = [SKAction runBlock:^{
        
        if(self.meteors.count <= 10)
        {
            [self AddMetors];
        }
        
//        for(SKSpriteNode* nod in self.meteors)
//        {
//            [nod runAction:[SKAction moveTo:self.sprite.position duration:2]];
//        }
        
    }];
    
    SKAction* action10 =  [SKAction runBlock:^(void)
     {
         for(SKSpriteNode* nod in self.meteors)
         {
             CGPoint point = CGPointMake(random() % 360,
                         random() % 568);
             [nod runAction:[SKAction moveTo:point duration:3]];
         }
     }];
    SKAction *actionWaitNextMonster = [SKAction waitForDuration:1];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[actionAddMonster,actionWaitNextMonster, action10]]]];

    
    [self.meteors addObject:met];

}

//http://www.raywenderlich.com/57370/trigonometry-game-programming-sprite-kit-version-part-2
//http://www.raywenderlich.com/51108/build-spaceinvaders-in-spritekit-part-2-of-2



-(void) config
{
    self.labelCounterX = [SKLabelNode new];
//    self.labelCounterX.text = @"Hello, World!";
    self.labelCounterX.fontSize = 10;
    self.labelCounterX.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame) - 10);
    [self addChild:self.labelCounterX];
    
    
    self.labelCounterY = [SKLabelNode new];
//    self.labelCounterY.text = @"Hello, World!";
    self.labelCounterY.fontSize = 10;
    self.labelCounterY.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame) - 20);
    [self addChild:self.labelCounterY];
    
    self.labelCounterZ = [SKLabelNode new];
//    self.labelCounterZ.text = @"Hello, World!";
    self.labelCounterZ.fontSize = 10;
    self.labelCounterZ.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame) - 30);
    [self addChild:self.labelCounterZ];
    
    
    //---
    self.labelYawDegrees = [SKLabelNode new];
//    self.labelYawDegrees.text = @"Hello, World!";
    self.labelYawDegrees.fontSize = 10;
    self.labelYawDegrees.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame) - 50);
    [self addChild:self.labelYawDegrees];
    
    
    self.labelPitchDegrees = [SKLabelNode new];
//    self.labelPitchDegrees.text = @"Hello, World!";
    self.labelPitchDegrees.fontSize = 10;
    self.labelPitchDegrees.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame) - 60);
    [self addChild:self.labelPitchDegrees];
    
    self.labelRollDegrees = [SKLabelNode new];
//    self.labelRollDegrees.text = @"Hello, World!";
    self.labelRollDegrees.fontSize = 10;
    self.labelRollDegrees.position = CGPointMake(CGRectGetMidX(self.frame),
                                              CGRectGetMidY(self.frame) - 70);
    [self addChild:self.labelRollDegrees];
    
    
    self.labelTimer = [SKLabelNode new];
    self.labelTimer.text = @"0.00";
    self.labelTimer.fontSize = 10;
    self.labelTimer.position = CGPointMake(CGRectGetMaxX(self.frame) - 70,
                                                 CGRectGetMaxY(self.frame) - 20);
    [self addChild:self.labelTimer];
    
    
//    self.labelTimer runAction:[SKAction repeatActionForever:<#(SKAction *)#>]
}


#define kPlayerSpeed 300

-(void)setupMovement
{
    self.myQueue = [[NSOperationQueue alloc] init];
    self.motionManager = [[CMMotionManager alloc] init];
    if ([self.motionManager isAccelerometerAvailable] == YES) {
        [self.motionManager startAccelerometerUpdatesToQueue:self.myQueue
                                            withHandler:^(CMAccelerometerData *data, NSError *error)
         {
             float destX, destY;
             float currentX = self.sprite.position.x;
             float currentY = self.sprite.position.y;
             BOOL shouldMove = NO;
             
             BOOL xMoved = NO;
             
             if(data.acceleration.y < -0.01) { // tilting the device to the right
                 destX = currentX - (data.acceleration.y * kPlayerSpeed);
                 destY = currentY;
                 shouldMove = YES;
                 
                 xMoved = YES;
             } else if (data.acceleration.y > 0.01) { // tilting the device to the left
                 destX = currentX - (data.acceleration.y * kPlayerSpeed);
                 destY = currentY;
                 shouldMove = YES;
                 xMoved = YES;
             }
             
             
             if(data.acceleration.x < -0.01) { // tilting the device to the right
                 destY = currentY + (data.acceleration.x * kPlayerSpeed/2);
                 
                 if(xMoved)
                 {
                     destX = destX;
                 }
                 else
                 {
                     destX = currentX;
                 }

                 shouldMove = YES;
             } else if (data.acceleration.x > 0.01) { // tilting the device to the left
                 destY = currentY + (data.acceleration.x * kPlayerSpeed/2);
                 
                 
                 
                 if(xMoved)
                 {
                     destX = destX;
                 }
                 else
                 {
                     destX = currentX;
                 }
                 
                 shouldMove = YES;
             }
             

             
             if(shouldMove) {
                 
                 if(destX < 0)
                 {
                     destX = 0;
                 }
                 else if(destX > self.frame.size.width)
                 {
                     destX = self.frame.size.width;
                 }
                 
                 
                 if(destY < 0)
                 {
                     destY = 0;
                 }
                 else if(destY > 406)
                 {
                     destY = 406;
                 }
                 
                 SKAction *action = [SKAction moveTo:CGPointMake(destX, destY) duration:.240];
                 
//                 [self.motionManager stopAccelerometerUpdates];
                 [self.sprite runAction:action];
             }
         }];
    }
}



-(void)AddShip
{
        //SKpriteNode
        self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        

        
        
        self.sprite.scale = 0.01;
        [self addChild:self.sprite];
        self.sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                           CGRectGetMidY(self.frame));;
        
        //move the ship using Sprite Kit's Physics Engine
        //1
        self.sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.sprite.frame.size];
        
        //2
        self.sprite.physicsBody.dynamic = YES;
        
        //3
        self.sprite.physicsBody.affectedByGravity = NO;
        
        //4
        self.sprite.physicsBody.mass = 0.1;
    
    
        self.sprite.physicsBody.collisionBitMask = 0;
        self.sprite.physicsBody.contactTestBitMask = 0;
    
        [self.sprite runAction:[SKAction scaleTo:0.05 duration:2]];
        
        [self.sprite runAction:[SKAction rotateByAngle: M_PI duration:1] completion:^(void)
         {
             //full rotate
             [self.sprite runAction:[SKAction rotateByAngle: M_PI duration:1] completion:^(void)
              {
                  [self setupMovement];
                  
                  for(int i=0;i<10;i++)
                  {
                      [self AddMetors];
                  }
              }];
         }];
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//    
//    for (UITouch *touch in touches) {
//
//        [self.sprite runAction:[SKAction moveTo:[touch locationInNode:self] duration:1]];
//    }
//}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
