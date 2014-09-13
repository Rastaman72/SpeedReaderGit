//
//  GraUkladankaViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface GraUkladankaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *wordsLengthDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
- (IBAction)lengthChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;
@property(nonatomic,strong)SharedData* xmlManager;
@property(nonatomic,strong)NSString* word;
@property(nonatomic,strong)NSMutableDictionary* lettersDic;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property(nonatomic,assign)int actualLetter;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
- (IBAction)helpPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *wordLengthView;
@property(nonatomic,assign)bool changePosition;
- (IBAction)startPush:(id)sender;

@end
