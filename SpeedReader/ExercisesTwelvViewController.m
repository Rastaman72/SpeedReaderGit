//
//  ExercisesTwelvViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/20/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesTwelvViewController.h"
#define P(x,y) CGPointMake(x, y)
@interface ExercisesTwelvViewController ()

@end

@implementation ExercisesTwelvViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pointsArray=[[NSMutableDictionary alloc]init];
    [self createPoints];
    [self addPointToLayer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addPointToLayer
{
    NSMutableArray *allKeys = [[self.pointsArray allKeys] mutableCopy];
    
    for (NSString *key in allKeys) {
        CALayer* object = [self.pointsArray objectForKey: key];
        [self.view.layer addSublayer:object];
        NSLog(@"%@",self.view.layer.sublayers);
    }
//    for (id singleLayer in self.pointsArray) {
//        [self.view.layer addSublayer:singleLayer];
//        NSLog(@"%@",self.view.layer.sublayers);
//    }
}

-(void)createPoints
{
    for (int i=0; i<9; i++) {
        
        int horAdd;
        int verAdd;
        if (i<3) {
            horAdd=100*i;
            verAdd=0;
        }
        else if(i>=3 && i <6)
        {
            horAdd=100*(i-3);
            verAdd=60;
        }
        else if (i>=6)
        {
            horAdd=100*(i-6);
            verAdd=120;
        }
        
        CGRect Rect = CGRectMake(50+horAdd, 50+verAdd, 15, 15);
        
    CALayer *point = [CALayer layer];
        [point setFrame:Rect];
        [point setBounds:Rect];
	point.backgroundColor=[[UIColor greenColor]CGColor];

    
        UIBezierPath *trackPath = [UIBezierPath bezierPath];
        [trackPath moveToPoint:P(point.frame.origin.x, point.frame.origin.y)];
        
        switch (i) {
            case 0:
                [trackPath addLineToPoint:P(point.frame.origin.x-50,point.frame.origin.y-50)];
                break;
            
            case 1:
                  [trackPath addLineToPoint:P(point.frame.origin.x,point.frame.origin.y-50)];
                break;
                
            case 2:
                  [trackPath addLineToPoint:P(point.frame.origin.x+50,point.frame.origin.y-50)];
                break;
                
            case 3:
                  [trackPath addLineToPoint:P(point.frame.origin.x-50,point.frame.origin.y)];
                break;
                
            case 5:
                  [trackPath addLineToPoint:P(point.frame.origin.x+50,point.frame.origin.y)];
                break;
                
            case 6:
                  [trackPath addLineToPoint:P(point.frame.origin.x-50,point.frame.origin.y+50)];
                break;
                
            case 7:
                  [trackPath addLineToPoint:P(point.frame.origin.x,point.frame.origin.y+50)];
                break;
                
            case 8:
                  [trackPath addLineToPoint:P(point.frame.origin.x+50,point.frame.origin.y+50)];
                break;
                
            default:
                break;
        };
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"dot1"];
        anim.delegate=self;
        anim.path = trackPath.CGPath;
        //anim.rotationMode = kCAAnimationRotateAuto;
      //  anim.repeatCount = HUGE_VALF;
        anim.duration = 1.0;
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        [point addAnimation:anim forKey:[NSString stringWithFormat:@"dot%d",i]];
        
        
        
//        
//        
//        CABasicAnimation *anim3 = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
//       /*anim3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//        anim3.fromValue = [NSNumber numberWithFloat:0];
//        anim3.toValue = [NSNumber numberWithFloat:40.0];
//        anim3.repeatCount = HUGE_VALF;
//        anim3.duration = 2.0;
//        */
//        
//        anim3.delegate = self;
//        
//        anim3.duration = 1;
//        
//        anim3.repeatCount = 0;
//        
//        anim3.removedOnCompletion = FALSE;
//        
//        anim3.fillMode = kCAFillModeForwards;
//        
//        anim3.autoreverses = NO;
//        
//        anim3.fromValue = [NSNumber numberWithFloat:0];
//        
//        anim3.toValue = [NSNumber numberWithFloat:15];
//        
//        
//        
//        [point addAnimation:anim3 forKey:@"position"];
//
//        
        //[self.view.layer addSublayer:point];
    [self.pointsArray setValue:point forKey:[NSString stringWithFormat:@"dot%d",i]];
}
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%@",anim);
    self.animFinish++;
    
    
    for (CALayer* singlePoint in self.pointsArray) {
        NSLog(@"%@",singlePoint);
    }
    
    
    NSMutableArray *allKeys = [[self.pointsArray allKeys] mutableCopy];
    
    for (NSString *key in allKeys) {
        CALayer* object = [self.pointsArray objectForKey: key];
        NSLog(@"%f",object.frame.origin.x);
    }
  
        
    
    
    
    if(self.animFinish==8)
    {
        self.animFinish=0;
        
        int a=5;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
