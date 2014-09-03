//
//  MetronumEXCViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface MetronumEXCViewController : UIViewController
- (IBAction)changeMode:(id)sender;
- (IBAction)speedReadChange:(id)sender;
- (IBAction)startPush:(id)sender;
- (IBAction)tickChange:(id)sender;
- (IBAction)tickPerWordChange:(id)sender;
- (IBAction)timerForMetronumChange:(id)sender;
- (IBAction)timerPush:(id)sender;
@property (nonatomic,assign)NSTimeInterval startTime;
@property (nonatomic,assign)bool running;
@property (weak, nonatomic) IBOutlet UIButton *startMetronumButton;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;
@property (weak, nonatomic) IBOutlet UILabel *timeForMetronumCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *setSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *setTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedReadCounter;
@property (weak, nonatomic) IBOutlet UILabel *speedReadLabel;
@property (weak, nonatomic) IBOutlet UILabel *tickCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *tickLabel;
@property (weak, nonatomic) IBOutlet UILabel *tickPerWordCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *tickPerWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeForMetronumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UISlider *speedReadSlider;
@property (weak, nonatomic) IBOutlet UISlider *tickPerWordSlider;
@property (weak, nonatomic) IBOutlet UISlider *tickSlider;
@property (weak, nonatomic) IBOutlet UISlider *timeForMetronumSlider;
@property (weak, nonatomic) IBOutlet UISwitch *chooseModeSlider;
@property(nonatomic,assign)  SystemSoundID metronom;
@property(nonatomic,assign)  SystemSoundID metronom2;
@property(nonatomic,strong) NSTimer *audioPlayingTimer;
@property(nonatomic,assign)int soundCounter;
@end
