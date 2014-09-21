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

- (IBAction)modeChange:(id)sender;
- (IBAction)numbersOfLineChange:(id)sender;
- (IBAction)startPush:(id)sender;
- (IBAction)wordLengthChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *numbersOfLineSlider;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UISwitch *selectModeSwitch;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *numbersOfLineView;
@property (weak, nonatomic) IBOutlet UIView *setModeView;
@property (weak, nonatomic) IBOutlet UIView *wordLengthView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool forward;
@property(nonatomic,assign)bool itWasBack;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)bool started;
@property(nonatomic,assign)int animFinish;
@property(nonatomic,assign)int increaseDistance;
@property(nonatomic,assign)int numbersOfLine;
@property(nonatomic,assign)int round;
@property(nonatomic,assign)int step;
@property(nonatomic,assign)int wordLength;
@property(nonatomic,strong) NSMutableArray *numbersOfLinesArray;
@property(nonatomic,strong) NSMutableArray *numbersWordLengthArray;
@property(nonatomic,strong) NSTimer *moveObjects;
@property(nonatomic,strong)NSMutableDictionary* objectDic;
@property(nonatomic,strong)SharedData* xmlManager;

typedef enum StateOfRound{
	Begin,
    Half,
    Finish}
StateOfRound;
@end
