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

- (IBAction)circleChange:(id)sender;
- (IBAction)sizeChange:(id)sender;
@property (nonatomic) CGPoint circleCenter;
@property (nonatomic) float circleRadius;
@property (nonatomic) float xPos;
@property (nonatomic) float yPos;
@property (nonatomic, assign) BOOL isMaskMoved;
@property (nonatomic,assign)int radius;
@property (weak, nonatomic) IBOutlet UISlider *circleSizeSlider;
@property (weak, nonatomic) IBOutlet UISlider *textSizeSlider;
@property (weak, nonatomic) IBOutlet UITextView *exerciseTextView;
@property (weak, nonatomic) IBOutlet UIView *circleSizeView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *textSizeView;
@property(nonatomic,assign) CGSize size;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)float numberOfLines;
@property(nonatomic,assign)float position;
@property(nonatomic,assign)int actuallOffset;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,strong)CALayer* readFrame;
@property(nonatomic,strong)SharedData* xmlManager;
@end
