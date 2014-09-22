//
//  ZaznaczCoWystapiloViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface ZaznaczCoWystapiloViewController : UIViewController
- (IBAction)answerPush:(id)sender;
- (IBAction)numbersOfLineChange:(id)sender;
- (IBAction)startPush:(id)sender;
- (IBAction)wordLengthChange:(id)sender;
- (IBAction)wordShowTimeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLineDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLengthDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordShowTimeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *numbersOfLineSlider;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UISlider *wordShowTimeSlider;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *numbersOfLineView;
@property (weak, nonatomic) IBOutlet UIView *wordLengthView;
@property (weak, nonatomic) IBOutlet UIView *wordShowView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool startPush;
@property(nonatomic,assign)int lineNumbers;
@property(nonatomic,assign)int wordLength;
@property(nonatomic,strong) NSMutableArray *numbersOfLineArray;
@property(nonatomic,strong) NSMutableArray *numbersWordLength;
@property(nonatomic,strong) NSTimer *wordShowTimer;
@property(nonatomic,strong)NSMutableArray* goodAnswer;
@property(nonatomic,strong)NSMutableArray* tempList;
@property(nonatomic,strong)NSMutableDictionary* numberDic;
@property(nonatomic,strong)SharedData* theDataObject;
@end
