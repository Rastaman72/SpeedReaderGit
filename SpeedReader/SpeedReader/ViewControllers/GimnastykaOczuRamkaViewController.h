//
//  ExercisesFifthteenViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface GimnastykaOczuRamkaViewController : UIViewController
- (IBAction)speedChange:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *speedDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *speedView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool started;
@property(nonatomic,assign)float upperBand;
@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,strong)NSMutableDictionary* rectangleDic;
@property(nonatomic,strong)SharedData* theDataObject;
@end
