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
@interface ExercisesTwentyThreeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *exercisesTwentyThreeText;
@property (weak, nonatomic) IBOutlet UISlider *exercisesTwentyThreeMinValueSLider;
@property (weak, nonatomic) IBOutlet UISlider *exercisesTwentyThreeMaxValue;
- (IBAction)minValueCHange:(id)sender;
- (IBAction)maxValueChange:(id)sender;

@property(nonatomic,assign)int maxLength;
@property(nonatomic,assign) int minLength;
@property(nonatomic,assign) int actuallLength;
@property(nonatomic,assign)int step;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,strong)NSString* actuallWord;
@end
