//
//  ExercisesTwentyFourViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/23/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExercisesTwentyFourViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *exercisesTwentyFourText;
@property (weak, nonatomic) IBOutlet UISlider *exercisesTwentyFourSlider;
- (IBAction)sizeChange:(id)sender;
@property(nonatomic,assign)bool mode;
@property(nonatomic,assign)int actuallSize;

@end
