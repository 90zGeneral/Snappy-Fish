//
//  ViewController.m
//  Snappy Fish5
//
//  Created by Roydon Jeffrey on 8/25/15.
//  Copyright (c) 2015 WDI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    //Setting up the high score
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreUpdated"];
    HighScore.text = [NSString stringWithFormat:@"High Score: %li", (long)HighScoreNumber];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
