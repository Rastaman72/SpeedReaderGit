//
//  SzukanieZnakowMigawkiViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/15/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface SzukanieZnakowMigawkiViewController : UIViewController

- (IBAction)modeChange:(id)sender;
- (IBAction)numbersOfLineChange:(id)sender;
- (IBAction)sizeChange:(id)sender;
- (IBAction)startPush:(id)sender;
- (IBAction)wordShowTimeView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *numbersOfLineSlider;
@property (weak, nonatomic) IBOutlet UISlider *sizeSlider;
@property (weak, nonatomic) IBOutlet UISlider *wordShowTimeSlider;
@property (weak, nonatomic) IBOutlet UISwitch *selectModeSwitch;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *numbersOfLineView;
@property (weak, nonatomic) IBOutlet UIView *setModeView;
@property (weak, nonatomic) IBOutlet UIView *sizeView;
@property (weak, nonatomic) IBOutlet UIView *wordShowTimeView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int actuallSize;
@property(nonatomic,assign)int choosedNumbersOfLine;
@property(nonatomic,assign)int choosedSize;
@property(nonatomic,assign)int goodAnswer;
@property(nonatomic,assign)int positionY;
@property(nonatomic,assign)int step;
@property(nonatomic,strong) NSTimer *showTableTimer;
@property(nonatomic,strong)NSArray*numberSizerray;
@property(nonatomic,strong)NSArray*numbersOfLineArray;
@property(nonatomic,strong)NSString* toFind;
@property(nonatomic,strong)SharedData* theDataObject;
@end
