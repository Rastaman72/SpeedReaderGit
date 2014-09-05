//
//  ExercisesTwentyFourViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiramidaTypKolumnowyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
- (IBAction)sizeChange:(id)sender;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int actuallSize;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *chooseModeSwitch;
- (IBAction)modeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthDescriptionLabel;
- (IBAction)getNewLetters:(id)sender;

@end
