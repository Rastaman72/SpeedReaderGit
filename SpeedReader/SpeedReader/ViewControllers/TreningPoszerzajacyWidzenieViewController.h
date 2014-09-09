//
//  TreningPoszerzajacyWidzenieViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface TreningPoszerzajacyWidzenieViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property(nonatomic,assign)bool mode;
@property (weak, nonatomic) IBOutlet UISwitch *selectModeSwitch;
- (IBAction)modeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;
@property(nonatomic,strong)SharedData* xmlManager;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *numbersOfLineSlider;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineCounterLabel;

@property (weak, nonatomic) IBOutlet UILabel *wordLengthDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
- (IBAction)numbersOfLineChange:(id)sender;
- (IBAction)wordLengthChange:(id)sender;
@property(nonatomic,strong)NSMutableDictionary* objectDic;
@property(nonatomic,assign)int numbersOfLine;
@property(nonatomic,assign)int wordLength;
@property(nonatomic,assign)int step;
@property(nonatomic,strong) NSMutableArray *numbersWordLengthArray;
@property(nonatomic,strong) NSMutableArray *numbersOfLinesArray;
@property(nonatomic,strong) NSTimer *moveObjects;
@end
