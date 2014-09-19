//
//  LessonData.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LessonData : NSObject
@property (nonatomic,strong)NSString* name;
@property (nonatomic,strong)NSString* description;
@property (nonatomic,strong)NSString* header;
@property (nonatomic,strong)NSString* userImage;
@property(nonatomic,strong)NSMutableDictionary* lessonPart;
@property(nonatomic,assign)int number;

+(LessonData*) newLessonWithName : (NSString*)name description:(NSString*)description number:(int)number;

@end
