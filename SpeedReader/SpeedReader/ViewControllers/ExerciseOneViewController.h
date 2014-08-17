//
//  ExerciseOneViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ExerciseOneViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *exercisesOneText;
@property(nonatomic,strong)SharedData* xmlManager;
@property (weak, nonatomic) IBOutlet UISlider *exercisesOneSizeSlider;
- (IBAction)sizeChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *test;
@property(nonatomic,assign)float position;

@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,assign)int actuallOffset;
- (void) autoscrollTimerFired;
@property(nonatomic,assign) CGSize size;
@property(nonatomic,assign)bool done;
@property (weak, nonatomic) IBOutlet UISlider *exercisesOneTimeSlider;
- (IBAction)timeChanged:(id)sender;
@property(nonatomic,strong)CALayer* readFrame;
@property (weak, nonatomic) IBOutlet UIButton *exercisesOneStartButton;
- (IBAction)startPush:(id)sender;
@end
