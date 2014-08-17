//
//  ExercisesDispatcherViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseOneViewController.h"
#import "ExercisesTwoViewController.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
#import "ExercisesData.h"
@interface ExercisesDispatcherViewController : UIViewController<UITextFieldDelegate>
- (IBAction)push:(id)sender;
@property(nonatomic,strong)SharedData* theDataObject;
-(void)test;
@end
