//
//  ExercisesDispatcherControllerViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExercisesData.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ExercisesDispatcherControllerViewController : UINavigationController
@property(nonatomic,strong)SharedData* theDataObject;
-(void)test;
@end
