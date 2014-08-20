//
//  ExercisesSixViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ExercisesSevenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *exercisesSevenText;
@property (weak, nonatomic) IBOutlet UIButton *exercisesSevenStartButton;
- (IBAction)startPush:(id)sender;
@property(nonatomic,strong)SharedData* xmlManager;
@end
