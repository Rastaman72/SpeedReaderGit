//
//  SuperSzybkoscViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface SuperSzybkoscViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *exerciseDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedReadCounter;
@property (weak, nonatomic) IBOutlet UILabel *speedReadLabel;
@property (weak, nonatomic) IBOutlet UISlider *speedReadSlider;
- (IBAction)speedChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *tickPerWordCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *tickPerWordLabel;
- (IBAction)tickPerWordChange:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *tickPerWordSlider;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)startPush:(id)sender;
@property(nonatomic,assign)  SystemSoundID metronom;
@property (nonatomic,assign)NSTimeInterval startTime;
@property (nonatomic,assign)bool running;
@property(nonatomic,assign)int soundCounter;
@property(nonatomic,strong) NSTimer *audioPlayingTimer;
@end
