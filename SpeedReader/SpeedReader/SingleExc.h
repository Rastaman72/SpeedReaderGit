//
//  SingleExc.h
//  SpeedReader
//
//  Created by LGBS dev on 9/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleExc : NSObject
@property(nonatomic,strong)NSString* excId;
@property(nonatomic,assign)int order;
@property(nonatomic,assign)int time;
@property(nonatomic,strong)NSMutableDictionary* params;
+(SingleExc*)createExc:(NSString*)excId order:(int)order time:(int)time params:(NSMutableDictionary*)params;

@end
