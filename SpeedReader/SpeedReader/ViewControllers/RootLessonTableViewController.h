//
//  LeftViewTableViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonSelectionDelegate.h"
#import "DetailLessonViewController.h"

@interface RootLessonTableViewController : UITableViewController
@property(nonatomic,retain) NSMutableArray* lessons;
@property (nonatomic,assign)id<LessonSelectionDelegate>delegate;

@end
