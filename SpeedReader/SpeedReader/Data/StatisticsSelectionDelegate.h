//
//  StatisticsSelectionDelegate.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StatisticsData;
@protocol StatisticsSelectionDelegate <NSObject>
@required
-(void)selectedStatistics:(StatisticsData*)newStatistics;
@end
