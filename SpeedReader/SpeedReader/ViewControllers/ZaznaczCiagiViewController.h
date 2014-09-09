//
//  ZaznaczCiagiViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZaznaczCiagiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int wordSize;
@property (weak, nonatomic) IBOutlet UISwitch *selectModeSwitch;
- (IBAction)modeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *legthWordDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
- (IBAction)wordLengthChange:(id)sender;
@property(nonatomic,strong)NSMutableDictionary* numberDic;
@property(nonatomic,strong) NSMutableArray *numbersWordLength;
@property(nonatomic,strong) NSString* goodAnswer;
@property(nonatomic,assign)int goodAnswerCounter;
@property(nonatomic,assign)bool startPushed;
@end
