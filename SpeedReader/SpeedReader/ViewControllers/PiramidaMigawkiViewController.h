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
@property (weak, nonatomic) IBOutlet UILabel *exerciseTextLabel;
@property (weak, nonatomic) IBOutlet UISlider *minWordLengthSLider;
@property (weak, nonatomic) IBOutlet UISlider *maxWordLengthSlider;
- (IBAction)minWordValueChange:(id)sender;
- (IBAction)maxWordValueChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *maxWordLengthCounterLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordShowTimeSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeCounterLabel;
- (IBAction)wordShowTimeChange:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *minWordLengthCounterLabel;
@property(nonatomic,assign)int maxLength;
@property(nonatomic,assign) int minLength;
@property(nonatomic,assign) int actuallLength;
@property(nonatomic,assign)int step;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,strong)NSString* actuallWord;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;
@property(nonatomic,assign)bool startPush;
@end
