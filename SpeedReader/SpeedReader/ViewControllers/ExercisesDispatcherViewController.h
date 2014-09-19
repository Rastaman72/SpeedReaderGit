//
//  ExercisesDispatcherViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/13/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Czytanie2WierszeNaRazViewController.h"
#import "ExercisesTwoViewController.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
#import "ExercisesData.h"
@interface ExercisesDispatcherViewController : UIViewController<UITextFieldDelegate>
- (IBAction)push:(id)sender;
@property(nonatomic,strong)SharedData* theDataObject;
@property (weak, nonatomic) IBOutlet UITextView *textView;
-(void)test;
@end
