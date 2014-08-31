//
//  ExerciseTwoViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/27/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface CzytanieBezSpacjiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)SharedData* xmlManager;
@end
