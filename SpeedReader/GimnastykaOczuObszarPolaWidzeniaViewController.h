//
//  ExercisesTwelvViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/20/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface GimnastykaOczuObszarPolaWidzeniaViewController : UIViewController

- (IBAction)speedChange:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *speedDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *speedView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)bool forward;
@property(nonatomic,assign)bool itWasBack;
@property(nonatomic,assign)bool startPush;
@property(nonatomic,assign)int animFinish;
@property(nonatomic,assign)int increaseDistance;
@property(nonatomic,assign)int positionX;
@property(nonatomic,assign)int positionY;
@property(nonatomic,assign)int round;
@property(nonatomic,assign)int step;
@property(nonatomic,strong)NSMutableDictionary* pointsArray;
@property(nonatomic,strong)NSTimer* scrollingTimer;
@property(nonatomic,strong)SharedData* theDataObject;
typedef enum StateOfRound{
	Begin,
    Half,
    Finish}
StateOfRound;
@end
