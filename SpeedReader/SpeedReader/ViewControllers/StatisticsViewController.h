//
//  StatisticsViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootStatisticsTableViewController.h"
#import "DetailStatisticsViewController.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface StatisticsViewController : UISplitViewController
@property(nonatomic,strong)SharedData* theDataObject;
@end
