//
//  ExercisesThirtyEigthViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/24/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface UkryteDolneCzesciLiterViewController : UIViewController

- (IBAction)shadowChange:(id)sender;
- (IBAction)sizeChange:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *shadowSizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *textSizeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *textSizeDescriptionlabel;
@property (weak, nonatomic) IBOutlet UISlider *shadowSizeSlider;
@property (weak, nonatomic) IBOutlet UISlider *textSizeSlider;
@property (weak, nonatomic) IBOutlet UITextView *exerciseTextView;
@property (weak, nonatomic) IBOutlet UIView *shadowSizeView;
@property (weak, nonatomic) IBOutlet UIView *textSizeView;
@property(nonatomic,assign) CGSize exerciseTextViewSize;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)float numberOfLines;
@property(nonatomic,assign)float position;
@property(nonatomic,assign)int actuallOffset;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,strong)CALayer* readFrame;
@property(nonatomic,strong)NSArray* toRetrieve;
@property(nonatomic,strong)SharedData* xmlManager;@end
