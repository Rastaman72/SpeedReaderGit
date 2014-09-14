//
//  ExercisesFourtyOneViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/25/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"

@interface WidzenieCyklopoweViewController : UIViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *exerciseTextView;
@property (weak, nonatomic) IBOutlet UISlider *circleSizeSlider;
- (IBAction)circleChange:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *textSizeSlider;
- (IBAction)sizeChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *textSizeView;

@property(nonatomic,strong)CALayer* readFrame;
@property(nonatomic,assign)float position;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,assign)int actuallOffset;

@property(nonatomic,assign) CGSize size;
@property(nonatomic,assign)float numberOfLines;
@property (weak, nonatomic) IBOutlet UIView *circleSizeView;

@property (nonatomic) CGPoint circleCenter;
@property (nonatomic) float circleRadius;
@property (nonatomic) float yPos;
@property (nonatomic) float xPos;

@property (nonatomic, assign) BOOL isMaskMoved;

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (nonatomic,assign)int radius;
@property(nonatomic,assign)bool changePosition;
@end
