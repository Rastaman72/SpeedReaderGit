//
//  ExercisesTwentyFourViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface PiramidaTypKolumnowyViewController : UIViewController

- (IBAction)changeElements:(id)sender;
- (IBAction)getNewLetters:(id)sender;
- (IBAction)modeChange:(id)sender;
- (IBAction)sizeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *changeElementsButton;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UISwitch *chooseModeSwitch;
@property (weak, nonatomic) IBOutlet UIView *setModeView;
@property (weak, nonatomic) IBOutlet UIView *wordLengthView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int actuallSize;
@property(nonatomic,assign)int chooseSize;
@property(nonatomic,assign)int positionY;
@property(nonatomic,strong)NSArray* wordLengthArray;
@property(nonatomic,strong)SharedData* theDataObject;
@end
