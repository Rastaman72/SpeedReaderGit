//
//  ExercisesSelectionDelegate.h
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ExercisesData;
@protocol ExercisesSelectionDelegate <NSObject>
@required
-(void)selectedExercises:(ExercisesData*)newExercises;
@end
