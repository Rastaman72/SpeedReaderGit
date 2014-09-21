//
//  RightViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonSelectionDelegate.h"
#import "SharedData.h"
#import "AppDelegateDataShared.h"
#import "LessonPartDispatcherViewController.h"
#import "GDataXMLNode.h"
#import "SingleExc.h"

@class LessonData;
@interface DetailLessonViewController : UIViewController<LessonSelectionDelegate,UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *lessonSinglePart;
@property(nonatomic,retain)LessonData* lessonData;
@property (weak, nonatomic) IBOutlet UIImageView *detailLessonUserImage;
@property (weak, nonatomic) IBOutlet UITextView *detailLessonDecription;
@property (weak, nonatomic) IBOutlet UILabel *detailLessonHeader;

@property (nonatomic, weak) IBOutlet UINavigationItem *navBarItem;
@property (nonatomic, strong) UIPopoverController *popover;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutButton;
- (IBAction)logOutPush:(id)sender;
@property(nonatomic,strong)SharedData* theDataObject;
-(void)setLesson:(LessonData *)lesson;
@property (weak, nonatomic) IBOutlet UIButton *goToExerciseButton;
@property(nonatomic,strong)LessonPartDispatcherViewController* lessonPart;
@property(nonatomic,strong)NSMutableDictionary* listOfExercises;
@property(nonatomic,strong)NSMutableDictionary* dictionaryOfParams;
@property(nonatomic,strong)NSMutableArray* sortedExcNumber;
@property(nonatomic,assign)int actuallExc;

@end
