//
//  StoperEXCViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoperEXCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *startTimerLabel;
- (IBAction)startPush:(id)sender;
@property (nonatomic,assign)bool running;
@property (nonatomic,assign)NSTimeInterval startTime;

@end
