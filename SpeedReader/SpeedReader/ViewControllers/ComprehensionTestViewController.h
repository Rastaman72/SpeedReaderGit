//
//  ComprehensionTestViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ComprehensionTestViewController : UIViewController
@property(nonatomic,strong)SharedData* theDataObject;
@property (weak, nonatomic) IBOutlet UIScrollView *gameView;
@property(nonatomic,assign)bool changePosition;
@end
