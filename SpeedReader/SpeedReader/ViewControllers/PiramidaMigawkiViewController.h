//
//  ExercisesTwentyThreeViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface PiramidaMigawkiViewController : UIViewController

- (IBAction)maxWordValueChange:(id)sender;
- (IBAction)minWordValueChange:(id)sender;
- (IBAction)startPush:(id)sender;
- (IBAction)wordShowTimeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *exerciseTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxWordLengthCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *minWordLengthCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeCounterLabel;
@property (weak, nonatomic) IBOutlet UISlider *maxWordLengthSlider;
@property (weak, nonatomic) IBOutlet UISlider *minWordLengthSLider;
@property (weak, nonatomic) IBOutlet UISlider *wordShowTimeSlider;
@property (weak, nonatomic) IBOutlet UIView *maxWordLengthView;
@property (weak, nonatomic) IBOutlet UIView *minWordLengthView;
@property (weak, nonatomic) IBOutlet UIView *wordShowTimeView;
@property(nonatomic,assign) int actuallLength;
@property(nonatomic,assign) int minLength;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool startPush;
@property(nonatomic,assign)int maxLength;
@property(nonatomic,assign)int step;
@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,strong)NSString* actuallWord;
@property(nonatomic,strong)SharedData* xmlManager;
@end
