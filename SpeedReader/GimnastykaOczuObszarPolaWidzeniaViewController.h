//
//  ExercisesTwelvViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/20/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GimnastykaOczuObszarPolaWidzeniaViewController : UIViewController
@property(nonatomic,strong)NSMutableDictionary* pointsArray;
@property(nonatomic,assign)int animFinish;
@property(nonatomic,assign)bool forward;
@property(nonatomic,assign)bool itWasBack;
@property(nonatomic,assign)int round;
@property(nonatomic,assign)int increaseDistance;
@property(nonatomic,strong)NSTimer* scrollingTimer;
typedef enum StateOfRound{
	Begin,
    Half,
    Finish}
StateOfRound;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
- (IBAction)speedChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startPush:(id)sender;

@end
