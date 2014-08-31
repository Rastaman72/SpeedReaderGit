//
//  CzytanieZPlamamiViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/27/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface CzytanieZPlamamiViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,strong)CALayer* readFrame;
@property (weak, nonatomic) IBOutlet UIButton *startButtron;
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)sizeChanged:(id)sender;
- (IBAction)sizeDynamic:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *textSizeSlider;
@property(nonatomic,assign) CGSize size;
@property (weak, nonatomic) IBOutlet UILabel *textSizeDescriptionLabel;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,assign)float position;
- (IBAction)startPush:(id)sender;
@property(nonatomic,assign)bool startPush;
@end
