//
//  LessonSelectionDelegate.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LessonData;
@protocol LessonSelectionDelegate <NSObject>
@required
-(void)selectedLesson:(LessonData*)newLesson;
@end
