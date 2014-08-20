//
//  BaseExercisesViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseExercisesViewController : UIViewController
@property(nonatomic,strong) NSTimer *scrollingTimer;
-(void)startExercises:(UISlider*)exercisesSlider;
@end
