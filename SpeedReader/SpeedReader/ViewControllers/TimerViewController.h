//
//  TimerViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/6/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController
- (IBAction)backPush:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *timerViewNavBar;
@property (weak, nonatomic) IBOutlet UILabel *timerViewTimerLabel;
@property (weak, nonatomic) IBOutlet UIButton *timerViewStartTimerButton;
- (IBAction)startPush:(id)sender;
@property (nonatomic,assign)bool running;
@property (nonatomic,assign)NSTimeInterval startTime;

@end
