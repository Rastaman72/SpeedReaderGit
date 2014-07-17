//
//  LessonData.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LessonData : NSObject
@property (nonatomic,retain)NSString* name;
@property (nonatomic,retain)NSString* description;
@property (nonatomic,retain)NSString* header;
@property (nonatomic,retain)NSString* userImage;

+(LessonData*) newLessonWithName : (NSString*)name description:(NSString*)description;

@end
