//
//  LSViewController.m
//  MyFirstGame
//
//  Created by Melissa Pringle on 20/03/2014.
//  Copyright (c) 2014 Melissa Pringle. All rights reserved.
//

#import "LSViewController.h"
#import "LSMyScene.h"

@implementation LSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [LSMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}

//- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
//    NSLog(@"(%.02f, %.02f, %.02f)", acceleration.x, acceleration.y, acceleration.z);
//    slider.value = acceleration.x;
//}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    } else {
//        return UIInterfaceOrientationMaskAll;
//    }
    
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
