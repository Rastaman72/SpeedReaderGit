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
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property(nonatomic,strong)SharedData* xmlManager;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *numbersOfLinesDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *numbersOfLineSlider;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfLinesCounterLabel;
- (IBAction)numberOfLinesChange:(id)sender;
@property(nonatomic,strong)NSMutableArray* numbersOfLinesArray;
@property(nonatomic,strong)NSMutableDictionary* objectDic;
@property(nonatomic,assign)int numbersOfLine;
@property(nonatomic,assign)int step;
@property (weak, nonatomic) IBOutlet UIView *numbersOfLineView;
@property(nonatomic,assign)bool changePosition;
@end
