//
//  Game.h
//  Snappy Fish5
//
//  Created by Roydon Jeffrey on 8/25/15.
//  Copyright (c) 2015 WDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

//Declare integer variables for everything moving on the screen
int fishSwim;
int randTopPipePos;
int randBottomPipePos;
int scoreNumber;

@interface Game : UIViewController {
    
    //Decalre all the visuals for the game as objects
    //IBOutlet states that these things will be affected in the storyboard. Stands for Interface Builder
    IBOutlet UIImageView *fish;
    IBOutlet UIImageView *topPipe;
    IBOutlet UIImageView *bottomPipe;
    IBOutlet UIImageView *top;
    IBOutlet UIImageView *bottom;
    IBOutlet UIButton *startGame;
    IBOutlet UILabel *scoreText;
    
    IBOutlet UIImageView *bubble;
    
    //Set timer objects for the bird and pipes when in action
    //NS = NextStep
    NSTimer *fishMove;
    NSTimer *pipeMove;
    
    //Declare audio player object
    AVAudioPlayer *_audioPlayer;

    
}

//Declare the action methods that controls the game
- (IBAction)startGame:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)fishMoving;
- (void)pipesMoving;
- (void)newPipes;
- (void)score;
- (void)gameOver;


@end
