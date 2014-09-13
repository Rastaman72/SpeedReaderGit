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
@property (weak, nonatomic) IBOutlet UIButton *startTimerButton;
- (IBAction)startPush:(id)sender;
@property (nonatomic,assign)bool running;
@property (nonatomic,assign)NSTimeInterval startTime;
@property(nonatomic,assign)bool changePosition;

@end
