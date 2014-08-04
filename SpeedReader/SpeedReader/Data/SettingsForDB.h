//
//  SettingsForDB.h
//  SpeedReader
//
//  Created by LGBS dev on 8/4/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SettingsForDB : NSManagedObject

@property (nonatomic,assign)int interface;
@property (assign, nonatomic) int lastUsedText;
@property (assign, nonatomic) int lastLessonDone;
@end
