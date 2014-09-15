//
//  TabliceSchultzaKolejneLiczbyViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/6/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabliceSchultzaKolejneLiczbyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *charModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitModeLabel;
@property(nonatomic,assign)bool mode;
@property (weak, nonatomic) IBOutlet UISwitch *selectModeSwitch;
- (IBAction)modeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *squareSizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *squareSizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *squareSizeCounterLabel;
- (IBAction)squareSizeChange:(id)sender;
@property(nonatomic,strong)NSMutableDictionary* numberDic;
@property(nonatomic,assign)int squareSize;
@property(nonatomic,strong) NSMutableArray *numbersSquareSize;
@property(nonatomic,assign)bool changePosition;
@property (weak, nonatomic) IBOutlet UIView *setModeView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *squareSizeView;
@property(nonatomic,assign)int objectSize;

@end