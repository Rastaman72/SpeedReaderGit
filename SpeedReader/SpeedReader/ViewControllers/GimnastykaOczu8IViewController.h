//
//  GimnastykaOczu8IViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 9/1/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface GimnastykaOczu8IViewController : UIViewController
@property(nonatomic,strong)SharedData* theDataObject;
@property (weak, nonatomic) IBOutlet UIButton *changeDirectionButton;
- (IBAction)directionChanged:(id)sender;
@property(nonatomic,assign)bool direction;
@property(nonatomic,assign)int beginPoint;
@property(nonatomic,assign)int firstControlPoint;
@property(nonatomic,assign)double animDuration;
@property(nonatomic,assign)int secondControlPoint;
@property(nonatomic,assign)bool changePosition;
@end
