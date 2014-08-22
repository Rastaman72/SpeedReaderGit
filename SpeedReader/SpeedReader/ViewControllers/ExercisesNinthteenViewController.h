//
//  ExercisesNinthteenViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExercisesNinthteenViewController : UIViewController
@property(nonatomic,strong)NSMutableDictionary* numberDic;
@property(nonatomic,assign)int touchCounter;
@property(nonatomic,strong)CATextLayer* firstChoose;
@property(nonatomic,strong)NSMutableDictionary* keyToDelete;
@property(nonatomic,strong)NSString* firstObjectToDelete;
@property(nonatomic,strong)NSString* secondObjectToDelete;
@property(nonatomic,assign)bool change;
@end
