//
//  PiramidaWyrazyViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface PiramidaWyrazyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property(nonatomic,assign)int actuallSize;
@property(nonatomic,assign)int step;
- (IBAction)getNewWords:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getNewWordButton;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)int positionY;
@end
