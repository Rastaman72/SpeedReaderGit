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
@interface ExercisesThirtyEigthViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *exercisesThirtyEigthText;
@property (weak, nonatomic) IBOutlet UISlider *exercisesThirtyEigthSizeSlider;
@property (weak, nonatomic) IBOutlet UISlider *exercisesThirtyEigthShadowSlider;
- (IBAction)shadowChange:(id)sender;
- (IBAction)sizeChange:(id)sender;

@property(nonatomic,strong)CALayer* readFrame;
@property(nonatomic,assign)float position;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,assign)int actuallOffset;
@property(nonatomic,assign) CGSize size;
@property(nonatomic,assign)float numberOfLines;
@property(nonatomic,strong)NSArray* toRetrieve;
@end
