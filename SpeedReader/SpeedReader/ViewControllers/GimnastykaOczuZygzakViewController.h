//
//  GimnastykaOczuZygzakViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GimnastykaOczuZygzakViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *changeDirectionButton;
- (IBAction)directionChanged:(id)sender;
@property(nonatomic,assign)bool direction;
@end