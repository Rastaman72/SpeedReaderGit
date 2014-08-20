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
    self.forward=YES;
    self.pointsArray=[[NSMutableDictionary alloc]init];
    self.increaseDistance=0;
    [self createPoints];
    [self addPointToLayer];

   if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(2.0)
                                                               target:self selector:@selector(addAnimationToPoint) userInfo:nil repeats:YES];
    }
   // [self addAnimationToPoint];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createPoints
{
    for (int i=0; i<9; i++)
    {
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
        [self.pointsArray setValue:point forKey:[NSString stringWithFormat:@"dot %d",i]];
        
    }
}


-(void)addPointToLayer
{
    NSMutableArray *allKeys = [[self.pointsArray allKeys] mutableCopy];
    
    for (NSString *key in allKeys) {
        CALayer* object = [self.pointsArray valueForKey: key];
        [self.view.layer addSublayer:object];
       // NSLog(@"%@",self.view.layer.sublayers);
    }

}

- (void)addAnimationToPoint//:(int)i point:(CALayer *)point
{
    NSMutableArray *allKeys = [[self.pointsArray allKeys] mutableCopy];
    //self.forward=YES;
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.pointsArray objectForKey: key];
        //NSString* objectName=[self.pointsArray valueForKey:key];
        
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        
        UIBezierPath *trackPath;
        trackPath = [self createForwardPath:object i:[[words lastObject]intValue] forward:self.forward increaseOffset:self.increaseDistance*10];
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        anim.path = trackPath.CGPath;
        anim.duration = 1.5;
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
         anim.delegate=self;
        [object addAnimation:anim forKey:[NSString stringWithFormat:@"dot %d",[[words lastObject]intValue]]];
        [self.pointsArray setValue:object forKey:[NSString stringWithFormat:@"dot %d",[[words lastObject]intValue]]];
    }
}

- (UIBezierPath *)createForwardPath:(CALayer *)point i:(int)i forward:(BOOL)forward increaseOffset:(int)increaseOffset
{
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    int offset=50+increaseOffset;
    if(!forward)
        offset=-offset;
    
    CGFloat midX=CGRectGetMidX(point.frame);
    CGFloat midY=CGRectGetMidY(point.frame);
    
    [trackPath moveToPoint:P(midX, midY)];

    
    //[trackPath moveToPoint:P(point.frame.origin.x, midY)];
    
    switch (i) {
        case 0:
            [trackPath addLineToPoint:P(midX-offset,midY-offset)];
            break;
            
        case 1:
            [trackPath addLineToPoint:P(midX,midY-offset)];
            break;
            
        case 2:
            [trackPath addLineToPoint:P(midX+offset,midY-offset)];
            break;
            
        case 3:
            [trackPath addLineToPoint:P(midX-offset,midY)];
            break;
            
        case 5:
            [trackPath addLineToPoint:P(midX+offset,midY)];
            break;
            
        case 6:
            [trackPath addLineToPoint:P(midX-offset,midY+offset)];
            break;
            
        case 7:
            [trackPath addLineToPoint:P(midX,midY+offset)];
            break;
            
        case 8:
            [trackPath addLineToPoint:P(midX+offset,midY+offset)];
            break;
            
        default:
            break;
    };
    return trackPath;
}




-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.forward)
        self.forward=NO;
    else
        self.forward=YES;
    //if(self.forward)
   // {
    self.animFinish++;
    NSMutableArray *allKeys = [[self.pointsArray allKeys] mutableCopy];
    
    for (id key in allKeys)
    {
        CALayer* object = [self.pointsArray objectForKey: key];
        CAKeyframeAnimation* test=[object animationForKey:key];
        NSLog(@"%@",[object animationForKey:key]);
        if (anim==test)
        {
            CGPoint currentPosition = [[object presentationLayer] position];
            [object setFrame:CGRectMake((int)currentPosition.x, (int)currentPosition.y, object.frame.size.width, object.frame.size.width)];
            [object setBounds:CGRectMake((int)currentPosition.x, (int)currentPosition.y, object.frame.size.width, object.frame.size.width)];
            [self.pointsArray setObject:object forKey:key];
            
        }
        }
    self.increaseDistance++;
  //  }
   /* if( self.animFinish==8)
    
    {
        [self returnObjectToBegin];
        self.animFinish=0;
    }*/
}
/*
- (void)createPathForLoop
{
    NSMutableArray *allKeys = [[self.pointsArray allKeys] mutableCopy];
    
    for (NSString *key in allKeys) {
        CALayer* object = [self.pointsArray objectForKey: key];
        NSString* objectName=[self.pointsArray valueForKey:key];
        
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        
        UIBezierPath *trackPath;
        trackPath =  [self createForwardPath:object i:[[words lastObject]intValue] forward:self.forward increaseOffset:self.increaseDistance*10];
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        anim.delegate=self;
        anim.path = trackPath.CGPath;
        anim.duration = 1.0;
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        [object addAnimation:anim forKey:[NSString stringWithFormat:@"dot %d",[[words lastObject]intValue]]];
        [self.pointsArray setValue:object forKey:[NSString stringWithFormat:@"dot %d",[[words lastObject]intValue]]];
        
    }
}*/

-(void)returnObjectToBegin
{
    self.forward=NO;
    self.increaseDistance++;

   // [self addAnimationToPoint];
    //[self createPathForLoop];
  /*   if(self.increaseDistance<6)
    {
        self.forward=YES;
        [self createPathForLoop];
 
    }*/
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
