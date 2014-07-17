//
//  ExercisesData.m
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesData.h"

@implementation ExercisesData

+(ExercisesData*) newExercisesWithName:(NSString *)name description:(NSString *)description
{
    ExercisesData* exercises=[[ExercisesData alloc]init];
    exercises.name=name;
    exercises.description=description;
    return exercises;
}
@end