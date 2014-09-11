//
//  GimnastykaOczu8IViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/1/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GimnastykaOczu8IViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *changeDirectionButton;
- (IBAction)directionChanged:(id)sender;
@property(nonatomic,assign)bool direction;
@property(nonatomic,assign)int beginPoint;
@property(nonatomic,assign)int firstControlPoint;
@property(nonatomic,assign)int secondControlPoint;
@property(nonatomic,assign)bool changePosition;
@end
