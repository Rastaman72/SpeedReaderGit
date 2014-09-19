//
//  SingleExc.m
//  SpeedReader
//
//  Created by LGBS dev on 9/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SingleExc.h"

@implementation SingleExc
+(SingleExc*)createExc:(NSString*)excId order:(int)order time:(int)time params:(NSMutableDictionary*)params;
{
    SingleExc* newExc=[[SingleExc alloc]init];
    newExc.excId=excId;
    newExc.order=order;
    newExc.time=time;
    newExc.params=[[NSMutableDictionary alloc]init];
    newExc.params=params;
    return newExc;
}
@end
