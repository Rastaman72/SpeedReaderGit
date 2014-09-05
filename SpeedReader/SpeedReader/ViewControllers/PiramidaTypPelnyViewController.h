//
//  PiramidaTypPelnyViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiramidaTypPelnyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int actuallSize;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *chooseModeSwitch;
- (IBAction)modeChange:(id)sender;
@property(nonatomic,assign)int step;
- (IBAction)getNewLetters:(id)sender;

@end
