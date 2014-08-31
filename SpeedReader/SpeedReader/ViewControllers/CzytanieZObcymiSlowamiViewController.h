//
//  ExercisesFiveViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/18/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
#import <stdlib.h>

@interface CzytanieZObcymiSlowamiViewController : UIViewController
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)SharedData* xmlManager;

@end
