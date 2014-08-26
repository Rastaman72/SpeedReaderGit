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

@interface ExercisesFourtyOneViewController : UIViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *exercisesFoutyOneText;
@property (weak, nonatomic) IBOutlet UISlider *exercisesFourtyOneCircleSizeSlider;
- (IBAction)circleChange:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *exercisesFourtyOneSizeSlider;
- (IBAction)sizeChange:(id)sender;

@property(nonatomic,strong)CALayer* readFrame;
@property(nonatomic,assign)float position;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,assign)int actuallOffset;

@property(nonatomic,assign) CGSize size;
@property(nonatomic,assign)float numberOfLines;

@property (nonatomic) CGPoint circleCenter;
@property (nonatomic) float circleRadius;
@property (nonatomic) float yPos;
@property (nonatomic) float xPos;

@property (nonatomic, assign) BOOL isMaskMoved;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@end
