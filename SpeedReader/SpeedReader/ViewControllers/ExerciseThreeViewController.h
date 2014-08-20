//
//  ExerciseThreeViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ExerciseThreeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *exercisesThreeText;
@property(nonatomic,strong)SharedData* xmlManager;
@property (weak, nonatomic) IBOutlet UISlider *exercisesThreeSizeSlider;
- (IBAction)sizeChanged:(id)sender;
@property(nonatomic,assign)float position;

@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,assign)int actuallOffset;
- (void) autoscrollTimerFired;
@property(nonatomic,assign) CGSize size;
@property(nonatomic,assign)bool done;
@property (weak, nonatomic) IBOutlet UISlider *exercisesThreeTimeSlider;
- (IBAction)timeChanged:(id)sender;
@property(nonatomic,strong)CALayer* readFrame;
@property (weak, nonatomic) IBOutlet UIButton *exercisesThreeStartButton;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *exercisesThreeJumpSlider;
- (IBAction)jumpChange:(id)sender;
@property(nonatomic,assign) float jumpWidth;
@property(nonatomic,assign) float jumpOffset;
@property(nonatomic,assign) int jumpCounter;
@property(nonatomic,assign)bool startPush;
@property(nonatomic,assign)bool resetLine;
@end
