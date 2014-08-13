//
//  ExercisesViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootExercisesTableViewController.h"
#import "DetailExercisesViewController.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
#import "ExercisesDispatcherViewController.h"
@interface ExercisesViewController : UISplitViewController
@property(nonatomic,strong)SharedData* theDataObject;

@end
