//
//  RootExercisesTableViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExercisesSelectionDelegate.h"
#import "DetailExercisesViewController.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"

@interface RootExercisesTableViewController : UITableViewController
@property(nonatomic,retain) NSMutableArray* exercises;
@property (nonatomic,assign)id<ExercisesSelectionDelegate>delegate;
@property(nonatomic,strong)SharedData* theDataObject;
@end
