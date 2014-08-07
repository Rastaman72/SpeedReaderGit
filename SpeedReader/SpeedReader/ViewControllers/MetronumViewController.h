//
//  MetronumViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/6/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetronumViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *metronumViewNavBar;
- (IBAction)backPush:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *metronumViewTimeForMetronumLabel;
@property (weak, nonatomic) IBOutlet UISlider *metronumViewTimeForMetronumSlider;
- (IBAction)timerForMetronumChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *metronumVIewTimeForMetronumCounter;

@property (weak, nonatomic) IBOutlet UILabel *metronumViewTickLabel;
@property (weak, nonatomic) IBOutlet UISlider *metronumViewTickSlider;
- (IBAction)tickChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewTickCounter;

@property (weak, nonatomic) IBOutlet UILabel *metronumViewSpeedReadLabel;
@property (weak, nonatomic) IBOutlet UISlider *metronumViewSpeedReadSlider;
- (IBAction)speedReadChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewSpeedReadCounter;

@property (weak, nonatomic) IBOutlet UILabel *metronumViewTickPerWordLabel;
@property (weak, nonatomic) IBOutlet UISlider *metronumViewTickPerWordSlider;
- (IBAction)tickPerWordChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewTickPerWordCounter;

@property (weak, nonatomic) IBOutlet UILabel *metronumViewTimerLabel;
@property (weak, nonatomic) IBOutlet UIButton *metronumViewTimerButton;
@property (nonatomic,assign)bool running;
@property (nonatomic,assign)NSTimeInterval startTime;

- (IBAction)timerPush:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *metronumViewSetTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewSetSpeedLabel;
@property (weak, nonatomic) IBOutlet UISwitch *metronumVIewChooseModeSlider;
- (IBAction)changeMode:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *metrnumViewStartMetronumButton;
- (IBAction)startPush:(id)sender;


@end
