//
//  TreningPionowegoWidzeniaViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface TreningPionowegoWidzeniaViewController : UIViewController

- (IBAction)numberOfLinesChange:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLinesCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLinesDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *numbersOfLineSlider;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *numbersOfLineView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)int numbersOfLine;
@property(nonatomic,assign)int step;
@property(nonatomic,strong)NSMutableArray* numbersOfLinesArray;
@property(nonatomic,strong)NSMutableDictionary* objectDic;
@property(nonatomic,strong)SharedData* xmlManager;
@end
