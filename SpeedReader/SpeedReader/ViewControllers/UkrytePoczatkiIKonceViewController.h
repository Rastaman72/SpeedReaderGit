//
//  UkrytePoczatkiIKonceViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/10/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface UkrytePoczatkiIKonceViewController : UIViewController

- (IBAction)shadowChange:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *shadowDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *shadowSizeSlider;
@property (weak, nonatomic) IBOutlet UITextView *exerciseTextView;
@property (weak, nonatomic) IBOutlet UIView *shadowSizeView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property(nonatomic,assign) CGSize exerciseTextViewSize;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)float numberOfLines;
@property(nonatomic,assign)float position;
@property(nonatomic,assign)int actuallOffset;
@property(nonatomic,assign)int maxPosition;
@property(nonatomic,strong)NSArray* toRetrieve;
@property(nonatomic,strong)SharedData* xmlManager;
@end
