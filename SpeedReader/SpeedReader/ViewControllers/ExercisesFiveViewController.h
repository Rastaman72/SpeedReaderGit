//
//  ExercisesFiveViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/18/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
#import <stdlib.h>

@interface ExercisesFiveViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *exercisesFiveText;
@property (weak, nonatomic) IBOutlet UIButton *exercisesFiveStartButton;
- (IBAction)startPush:(id)sender;
@property(nonatomic,strong)SharedData* xmlManager;

@end
