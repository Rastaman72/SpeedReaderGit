//
//  StatisticsData.m
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "StatisticsData.h"

@implementation StatisticsData

+(StatisticsData*) newStatisticsWithName:(NSString *)name description:(NSString *)description{
    StatisticsData* statistics=[[StatisticsData alloc]init];
    statistics.name=name;
    statistics.description=description;
    return statistics;
}
@end
