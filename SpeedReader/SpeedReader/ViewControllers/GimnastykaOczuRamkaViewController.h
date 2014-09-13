//
//  ExercisesFifthteenViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GimnastykaOczuRamkaViewController : UIViewController
@property(nonatomic,strong) NSTimer *scrollingTimer;
@property(nonatomic,strong)NSMutableDictionary* rectangleDic;
@property(nonatomic,assign)float upperBand;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UILabel *speedDescriptionLabel;
- (IBAction)speedChange:(id)sender;
@property(nonatomic,assign)bool started;
@property (weak, nonatomic) IBOutlet UIView *speedView;
@property(nonatomic,assign)bool changePosition;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@end
