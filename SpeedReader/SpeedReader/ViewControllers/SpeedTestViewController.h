//
//  SpeedTestViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface SpeedTestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)SharedData* theDataObject;
@end
