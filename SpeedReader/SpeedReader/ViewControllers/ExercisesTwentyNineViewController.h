//
//  ExercisesTwentyNineViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/24/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <stdlib.h>
@interface ExercisesTwentyNineViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *exercisesTwentyNineText;
@property (weak, nonatomic) IBOutlet UISlider *exercisesTwentyNineSlider;
- (IBAction)sizeChange:(id)sender;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int actuallSize;
@property(nonatomic,strong)NSString* toFind;
@property(nonatomic,assign)int goodAnswer;
@end
