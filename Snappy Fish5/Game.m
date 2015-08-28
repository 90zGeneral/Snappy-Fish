//
//  Game.m
//  Snappy Fish5
//
//  Created by Roydon Jeffrey on 8/25/15.
//  Copyright (c) 2015 WDI. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

//IN MANY CASES, THE BEGINNING OF A KEYWORD IN OBJECTIVE-C LETS YOU KNOW WHICH FRAMEWORK IS BEING USED


//To make the start button function accordingly
- (IBAction)startGame:(id)sender {
    
    //An array of pics for the animation
    bubble.animationImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"gold-fish2.png"],
                              [UIImage imageNamed:@"gold-fish3.png"], nil];
    //Anything after 'nil' will not be read by objective-c compiler. Basically means stop processing.
    
    
    
    
    [bubble setAnimationRepeatCount:0.1];
    bubble.animationDuration = 2;
    //[bubble startAnimating];
    
    
    //To Set the bird at this position each time the game starts. CG means Core Graphics
    fish.center = CGPointMake(85, 307);
    
    //Set score
    scoreNumber = 0;
    
    //Determining what to display after the game starts
    startGame.hidden = YES;
    topPipe.hidden = NO;
    bottomPipe.hidden = NO;
    fish.hidden = NO;
    scoreText.hidden = YES;
    
    
    //This determines the movement of the fish when the fishMoving method runs every 0.05 seconds
    //The higher the scheduledTimerWithTimeInterval number, the slower the movement
    fishMove = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(fishMoving) userInfo:nil repeats:YES];
    
    //Call this method to bring in new pipes when the game starts
    [self newPipes];
    
    //This determine the movement of the pipes when the pipesMoving method runs every 0.01 seconds
    pipeMove = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(pipesMoving) userInfo:nil repeats:YES];
    
    //Begin playing sound
    [_audioPlayer play];
    
}

//This determines how high the fish swims when user taps the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    fishSwim = 20;
    
}

//Determining the new position of the fish after the screen has been tapped
- (void)fishMoving {
    
    //The higher up the screen, the smaller the y coordinate gets. So I minus fishSwim from the y to make the fish go up each time there's a tap.
    fish.center = CGPointMake(fish.center.x, fish.center.y - fishSwim);
    
    //To slightly bring down the fish
    fishSwim = fishSwim - 5;
    
    //The lower the number each time 5 is minus, the faster the fish falls
    //This makes the fish descend at the same pace or else it would accelerate
    if (fishSwim < -15) {
        fishSwim = -15;
    }
    
}


- (void)pipesMoving {
    //To make the pipes move to the left by 1 each time this method runs every 0.01 seconds
    //The lower the number of the x coordinate as you move closer to the left of the screen
    topPipe.center = CGPointMake(topPipe.center.x - 1, topPipe.center.y);
    bottomPipe.center = CGPointMake(bottomPipe.center.x - 1, bottomPipe.center.y);
    
    //Based on the location of the current pipes, this decides when to bring in new pipes and increase score
    if (bottomPipe.center.x == -55) {
        [self score];
        [self newPipes];
    }
    
    //To determine how the fish dies
    if (CGRectIntersectsRect(fish.frame, topPipe.frame)) {
        [self gameOver];
    }
    
    if (CGRectIntersectsRect(fish.frame, bottomPipe.frame)) {
        [self gameOver];
    }
    
    if (CGRectIntersectsRect(fish.frame, bottom.frame)) {
        [self gameOver];
    }
    
}


- (void)newPipes {
    //Find a random y coordinate number to place the top pipe each time the method runs
    randTopPipePos = arc4random() %350;
    
    randTopPipePos = randTopPipePos - 228;
    randBottomPipePos = randTopPipePos + 690; //This controls the amount of space btw the 2 pipes. The bigger the number, the wider the space
    
    
    //Print figures to the console
    NSLog(@"%i", randTopPipePos);
    NSLog(@"%i", randBottomPipePos);
    
    
    //The x cordinates are the same so the top and bottom pipes can be in line everytime
    topPipe.center = CGPointMake(375, randTopPipePos);
    bottomPipe.center = CGPointMake(375, randBottomPipePos);
    
}

//State how much to increase the score
- (void)score {
    
    scoreNumber = scoreNumber + 1;
    
}

//What happens when the fish collides with a deadly object
- (void)gameOver {
    //Stop the timers
    [pipeMove invalidate];
    [fishMove invalidate];
    
    //The deciding factor when displaying the score after fish dies
    if (scoreNumber == 0) {
        scoreNumber = 0;
        scoreText.text = [NSString stringWithFormat:@"%i", scoreNumber];
    }else if (scoreNumber > 0) {
        [self score];
        scoreNumber = scoreNumber - 1;
        scoreText.text = [NSString stringWithFormat:@"%i", scoreNumber];
    }

    //Determining what to display after the game starts
    fish.hidden = YES;
    topPipe.hidden = NO;
    bottomPipe.hidden = NO;
    startGame.hidden = NO;
    scoreText.hidden = NO;
    
    //Stop playing sound
    [_audioPlayer stop];
    
    [bubble stopAnimating];
    
}

//Similar to jQuery window onlaod function
- (void)viewDidLoad {
    
    //Hide top and bottom pipes
    topPipe.hidden = YES;
    bottomPipe.hidden = YES;
    
    //Set score
    scoreNumber = 0;
    
    
    //Create URL path to sound file
    NSString *path = [NSString stringWithFormat:@"%@/Underwater-sound.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    
    //Create audio player object and initialize it
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    _audioPlayer.numberOfLoops = -1; //Infinite loop
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
