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
- (IBAction)helpPush:(id)sender;
- (IBAction)lengthChange:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordsLengthDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *wordLengthSlider;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *wordLengthView;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)int actualLetter;
@property(nonatomic,strong)NSMutableDictionary* lettersDic;
@property(nonatomic,strong)NSString* word;
@property(nonatomic,strong)SharedData* xmlManager;

@end
