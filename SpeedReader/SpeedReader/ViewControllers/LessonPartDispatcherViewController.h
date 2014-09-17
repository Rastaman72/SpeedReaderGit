//
//  LessonPartDispatcherViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExercisesData.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface LessonPartDispatcherViewController : UINavigationController
@property(nonatomic,strong)SharedData* theDataObject;
-(void)test1;
@end
