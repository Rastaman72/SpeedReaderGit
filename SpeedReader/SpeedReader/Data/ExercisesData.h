//
//  ExercisesData.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExercisesData : NSObject
@property (nonatomic,retain)NSString* name;
@property (nonatomic,retain)NSString* description;
@property (nonatomic,retain)NSString* header;
@property  (nonatomic,assign)int choosedExercises;

+(ExercisesData*) newExercisesWithName : (NSString*)name description:(NSString*)description number:(int)choose;


@end
