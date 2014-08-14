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
@property(nonatomic,assign)int position;
@end
