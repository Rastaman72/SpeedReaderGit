//
//  ExercisesNinthteenViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraMemoryViewController : UIViewController
- (IBAction)sizeChange:(id)sender;
- (IBAction)sizeDynamic:(id)sender;
- (IBAction)startPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *sizeDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *sizeSlider;
@property(nonatomic,assign)bool change;
@property(nonatomic,assign)int touchCounter;

@property(nonatomic,assign)int horizontalSize;
@property(nonatomic,assign)int verticalSize;
@property(nonatomic,strong)CATextLayer* firstChoose;
@property(nonatomic,strong)NSMutableDictionary* keyToDelete;
@property(nonatomic,strong)NSMutableDictionary* numberDic;
@property(nonatomic,strong)NSString* firstObjectToDelete;
@property(nonatomic,strong)NSString* secondObjectToDelete;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property(nonatomic,strong)NSMutableArray* randomValueArray;
@property (weak, nonatomic) IBOutlet UIView *sizeView;
@property(nonatomic,assign)bool changePosition;
@property (weak, nonatomic) IBOutlet UILabel *sizeCounterLabel;
@property(nonatomic,strong)NSArray* numberSize;
@property(nonatomic,assign)int chooseSize;
@property(nonatomic,assign)int squareSize;
@property(nonatomic,assign)int positionX;
@end
