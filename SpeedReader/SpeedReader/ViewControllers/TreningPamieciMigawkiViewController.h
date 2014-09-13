//
//  TreningPamieciMigawkiViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/8/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface TreningPamieciMigawkiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int wordSize;
@property (weak, nonatomic) IBOutlet UISwitch *selectModeSwitch;
- (IBAction)modeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;
@property(nonatomic,strong)SharedData* xmlManager;
@property (weak, nonatomic) IBOutlet UILabel *squareSizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *squareSizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *squareSizeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *legthWordDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
- (IBAction)squareSizeChange:(id)sender;
- (IBAction)wordLengthChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *wordLengthView;
@property (weak, nonatomic) IBOutlet UIView *squareSizeView;
@property(nonatomic,strong)NSMutableDictionary* numberDic;
@property(nonatomic,assign)int squareSize;
@property(nonatomic,strong) NSMutableArray *numbersWordLength;
@property(nonatomic,strong) NSMutableArray *numbersSquareSize;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordShowSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeCounterLabel;
- (IBAction)showTimeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *wordShowTImeView;
@property(nonatomic,strong) NSTimer *showTableTimer;
@property (weak, nonatomic) IBOutlet UIView *setModeView;
@property(nonatomic,assign)bool changePosition;
@end
