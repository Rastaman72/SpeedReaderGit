//
//  ZaznaczCoWystapiloViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZaznaczCoWystapiloViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordShowTimeSlider;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeCounterLabel;
- (IBAction)wordShowTimeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;

@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
- (IBAction)wordLengthChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineCounterLabel;
- (IBAction)numbersOfLineChange:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *numbersOfLineSlider;
@property(nonatomic,strong) NSTimer *wordShowTimer;
@property(nonatomic,assign)bool startPush;
@property(nonatomic,strong)NSMutableDictionary* numberDic;

- (IBAction)answerPush:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property(nonatomic,strong) NSMutableArray *numbersWordLength;
@property(nonatomic,strong) NSMutableArray *numbersOfLineArray;
@property(nonatomic,assign)int wordLength;
@property(nonatomic,assign)int lineNumbers;
@property(nonatomic,strong)NSMutableArray* goodAnswer;
@end
