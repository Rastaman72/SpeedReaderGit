//
//  PiramidaTypPelnyViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface PiramidaTypPelnyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property(nonatomic,assign)bool mode;
@property(nonatomic,strong)SharedData* theDataObject;
@property(nonatomic,assign)int actuallSize;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *chooseModeSwitch;
- (IBAction)modeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *setModeView;
@property(nonatomic,assign)int step;
- (IBAction)getNewLetters:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *generateObjectsButton;
@property (weak, nonatomic) IBOutlet UIButton *generateObjectPush;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)int positionY;
@end
