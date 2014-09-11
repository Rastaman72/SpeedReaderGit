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
@interface Czytanie2WierszeNaRazViewController : UIViewController<UITextViewDelegate>

- (IBAction)sizeChanged:(id)sender;
- (IBAction)sizeDynamic:(id)sender;
- (IBAction)startPush:(id)sender;
- (IBAction)timeChanged:(id)sender;
- (IBAction)timeDynamic:(id)sender;
- (void) autoscrollTimerFired;

@property (weak, nonatomic) IBOutlet UIButton *startButtron;
@property (weak, nonatomic) IBOutlet UILabel *frameSpeedDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *textSizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *frameSpeedSlider;
@property (weak, nonatomic) IBOutlet UISlider *textSizeSlider;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *frameSpeedView;
@property (weak, nonatomic) IBOutlet UIView *textSizeView;

@property(nonatomic,assign) CGSize size;
@property(nonatomic,assign) CGRect sizeR;
@property(nonatomic,assign)bool done;
@property(nonatomic,assign)bool startPush;
@property(nonatomic,assign)float position;
@property(nonatomic,assign)int actuallOffset;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,strong)CALayer* readFrame;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,assign)bool changePosition;

@end
