//
//  GraRiseViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface GraRiseViewController : UIViewController
- (IBAction)sizeChange:(id)sender;
- (IBAction)sizeDynamic:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *sizeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *sizeSlider;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UIView *sizeView;
@property(nonatomic,assign)bool change;
@property(nonatomic,assign)bool changePosition;
@property(nonatomic,assign)int chooseSize;
@property(nonatomic,assign)int choosedSize;
@property(nonatomic,assign)int lineSize;
@property(nonatomic,assign)int nextNumber;
@property(nonatomic,assign)int positionX;
@property(nonatomic,assign)int squareSize;
@property(nonatomic,assign)int touchCounter;
@property(nonatomic,assign)int wrongChooseCounter;
@property(nonatomic,strong)NSArray* numberSize;
@property(nonatomic,strong)NSMutableDictionary* numberDic;
@property(nonatomic,strong)SharedData* theDataObject;
@end
