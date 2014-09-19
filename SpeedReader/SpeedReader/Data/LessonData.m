//
//  LessonData.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "LessonData.h"

@implementation LessonData

+(LessonData*) newLessonWithName : (NSString*)name description:(NSString*)description number:(int)number
{
    LessonData* lesson=[[LessonData alloc]init];
    lesson.lessonPart=[[NSMutableDictionary alloc]init];
    lesson.name=name;
    lesson.description=description;
    lesson.number=number;
    return lesson;
}

@end
