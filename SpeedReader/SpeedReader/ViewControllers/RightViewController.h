//
//  RightViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LessonSelectionDelegate.h"
@class LessonData;
@interface RightViewController : UIViewController<LessonSelectionDelegate>

@property(nonatomic,retain)LessonData* lesson;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UITextView *decription;
@property (weak, nonatomic) IBOutlet UILabel *header;

@end
