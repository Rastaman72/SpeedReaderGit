//
//  ExercisesNineViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/19/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface CzytanieZeWskaznikiemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *pointerView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)CALayer* readFrameLayer;
@property(nonatomic,strong)SharedData* xmlManager;
@property (weak, nonatomic) IBOutlet UISlider *pickStyleSlider;
- (IBAction)pickerChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pickerValueLabel;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@property(nonatomic,assign)int chooseTrack;
@property(nonatomic,assign)int actuallOffset;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,assign) CGSize size;
@end
