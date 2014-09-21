//
//  ExercisesTwentyNineViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/24/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <stdlib.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface SzukanieSekwencjiWPiramidzieViewController : UIViewController
- (IBAction)modeChange:(id)sender;
- (IBAction)sizeChange:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UISlider *sizeSlider;
@property (weak, nonatomic) IBOutlet UISwitch *selectModeSwitch;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *setModeView;
@property (weak, nonatomic) IBOutlet UIView *sizeView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int actuallSize;
@property(nonatomic,assign)int goodAnswer;
@property(nonatomic,assign)int positionY;
@property(nonatomic,strong)NSString* toFind;
@property(nonatomic,strong)SharedData* theDataObject;
@end
