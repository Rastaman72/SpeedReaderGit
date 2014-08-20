//
//  ExercisesNineViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ExercisesNineViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *exercisesNineAnimationView;
@property (weak, nonatomic) IBOutlet UITextView *exercisesNineText;
@property(nonatomic,strong)CALayer* readFrame;
@property(nonatomic,strong)SharedData* xmlManager;
@end
