//
//  ExercisesFifthteenViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExercisesFifthteenViewController : UIViewController
@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,strong)NSMutableDictionary* rectangleDic;
@property(nonatomic,assign)float upperBand;
@end
