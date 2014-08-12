//
//  LessonsViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootLessonTableViewController.h"
#import "DetailLessonViewController.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface LessonsViewController : UISplitViewController
@property(nonatomic,strong)SharedData* theDataObject;
@end
