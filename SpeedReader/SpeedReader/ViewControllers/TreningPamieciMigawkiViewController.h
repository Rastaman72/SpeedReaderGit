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
- (IBAction)modeChange:(id)sender;
- (IBAction)showTimeChange:(id)sender;
- (IBAction)squareSizeChange:(id)sender;
- (IBAction)startPush:(id)sender;
- (IBAction)wordLengthChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *legthWordDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *squareSizeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *squareSizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *squareSizeSlider;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UISlider *wordShowSlider;
@property (weak, nonatomic) IBOutlet UISwitch *selectModeSwitch;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *setModeView;
@property (weak, nonatomic) IBOutlet UIView *squareSizeView;
@property (weak, nonatomic) IBOutlet UIView *wordLengthView;
@property (weak, nonatomic) IBOutlet UIView *wordShowTImeView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int squareSize;
@property(nonatomic,assign)int wordSize;
@property(nonatomic,strong) NSMutableArray *numbersSquareSize;
@property(nonatomic,strong) NSMutableArray *numbersWordLength;
@property(nonatomic,strong) NSTimer *showTableTimer;
@property(nonatomic,strong)NSMutableDictionary* numberDic;
@property(nonatomic,strong)SharedData* xmlManager;
@end
