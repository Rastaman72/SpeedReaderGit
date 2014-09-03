//
//  MetronumViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/6/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetronumViewController : UIViewController

- (IBAction)backPush:(id)sender;
- (IBAction)changeMode:(id)sender;
- (IBAction)speedReadChange:(id)sender;
- (IBAction)startPush:(id)sender;
- (IBAction)tickChange:(id)sender;
- (IBAction)tickPerWordChange:(id)sender;
- (IBAction)timerForMetronumChange:(id)sender;
- (IBAction)timerPush:(id)sender;
@property (nonatomic,assign)NSTimeInterval startTime;
@property (nonatomic,assign)bool running;
@property (weak, nonatomic) IBOutlet UIButton *metrnumViewStartMetronumButton;
@property (weak, nonatomic) IBOutlet UIButton *metronumViewTimerButton;
@property (weak, nonatomic) IBOutlet UILabel *metronumVIewTimeForMetronumCounter;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewSetSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewSetTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewSpeedReadCounter;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewSpeedReadLabel;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewTickCounter;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewTickLabel;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewTickPerWordCounter;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewTickPerWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewTimeForMetronumLabel;
@property (weak, nonatomic) IBOutlet UILabel *metronumViewTimerLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *metronumViewNavBar;
@property (weak, nonatomic) IBOutlet UISlider *metronumViewSpeedReadSlider;
@property (weak, nonatomic) IBOutlet UISlider *metronumViewTickPerWordSlider;
@property (weak, nonatomic) IBOutlet UISlider *metronumViewTickSlider;
@property (weak, nonatomic) IBOutlet UISlider *metronumViewTimeForMetronumSlider;
@property (weak, nonatomic) IBOutlet UISwitch *metronumVIewChooseModeSlider;
@end
