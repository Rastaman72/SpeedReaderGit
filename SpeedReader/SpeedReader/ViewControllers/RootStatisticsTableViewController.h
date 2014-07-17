//
//  RootStatisticsTableViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticsSelectionDelegate.h"
#import "DetailStatisticsViewController.h"

@interface RootStatisticsTableViewController : UITableViewController
@property(nonatomic,retain) NSMutableArray* statistics;
@property (nonatomic,assign)id<StatisticsSelectionDelegate>delegate;
@end
