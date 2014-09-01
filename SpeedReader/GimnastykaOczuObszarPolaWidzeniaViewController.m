//
//  ExercisesTwelvViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/20/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GimnastykaOczuObszarPolaWidzeniaViewController.h"
#define P(x,y) CGPointMake(x, y)
#define HALFSIZE object.frame.size.width/2
@interface GimnastykaOczuObszarPolaWidzeniaViewController ()

@end

@implementation GimnastykaOczuObszarPolaWidzeniaViewController

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
    self.itWasBack=NO;
    self.round=Begin;
    self.pointsArray=[[NSMutableDictionary alloc]init];
    self.increaseDistance=0;
    [self createPoints];
    [self addPointToLayer];

  
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
        CGRect Rect = CGRectMake(250+horAdd, 250+verAdd, 20, 20);
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
    NSLog(@"%@",@"animacja dodana");
    NSLog(@"%d",self.round);
    NSMutableArray *allKeys = [[self.pointsArray allKeys] mutableCopy];
   self.animFinish=0;
    
    if(self.round==Finish)
    {
        if(self.increaseDistance>=6)
            self.increaseDistance=0;
else
        self.increaseDistance++;
    }
    
    /*if(!self.itWasBack)
    {
        self.forward=YES;
        self.itWasBack=NO;
    }*/
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.pointsArray objectForKey: key];
        //NSString* objectName=[self.pointsArray valueForKey:key];
        
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        
        UIBezierPath *trackPath;
        
        
        trackPath = [self createForwardPath:object i:[[words lastObject]intValue] forward:self.forward increaseOffset:self.increaseDistance*20];
        
    
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        anim.path = trackPath.CGPath;
        anim.duration = 500/self.speedSlider.value;
        NSLog(@"%f",anim.duration);
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
         anim.delegate=self;
        [object addAnimation:anim forKey:[NSString stringWithFormat:@"dot %d",[[words lastObject]intValue]]];
        [self.pointsArray setValue:object forKey:[NSString stringWithFormat:@"dot %d",[[words lastObject]intValue]]];
        self.animFinish++;
    }
    
    if( self.animFinish==9)
        
    {
        self.itWasBack=!self.itWasBack;
        self.animFinish=0;
        self.forward=!self.forward;
       
    }
    
    switch (self.round) {
        case Begin:
            self.round=Half;
            break;
        
        case Half:
            self.round=Finish;
            break;
        case Finish:
            self.round=Half;
            break;
            
        default:
            break;
    }
    
   
    
}

- (UIBezierPath *)createForwardPath:(CALayer *)point i:(int)i forward:(BOOL)forward increaseOffset:(int)increaseOffset
{
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    int offset=50+increaseOffset;
    if(!forward)
        offset=-offset;
    int midX=CGRectGetMidX(point.frame);
    int midY=CGRectGetMidY(point.frame);
    
    [trackPath moveToPoint:P(midX, midY)];
    
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
   // NSLog(@"%@",@"animacja skonczona");
//    if (!self.forward) {
//        self.forward=YES;
//    }
    self.animFinish++;
    NSMutableArray *allKeys = [[self.pointsArray allKeys] mutableCopy];
    
   for (id key in allKeys)
    {
        CALayer* object = [self.pointsArray objectForKey: key];
        CAKeyframeAnimation* test=[object animationForKey:key];
        CGRect newFrame;
        CGPoint currentPosition = [[object presentationLayer] position];
     //   NSLog(@"%@",[object animationForKey:key]);
        int midX=CGRectGetMidX(object.frame);
        int midY=CGRectGetMidY(object.frame);
        if (anim==test)
        {
            newFrame=CGRectMake(currentPosition.x-HALFSIZE, currentPosition.y-HALFSIZE, object.frame.size.width, object.frame.size.width);
            [object setFrame:newFrame];
            [object setBounds:[[object presentationLayer] bounds]];
            [self.pointsArray setObject:object forKey:key];
            
        }
        }
}


-(void)returnObjectToBegin
{
   // self.forward=NO;
    //self.increaseDistance++;

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
//////////poprawic timingi


- (IBAction)speedChange:(id)sender {
    [self.scrollingTimer invalidate];
    self.scrollingTimer=nil;

    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(500/self.speedSlider.value+0.500)
                                                               target:self selector:@selector(addAnimationToPoint) userInfo:nil repeats:YES];
    }

}
- (IBAction)startPush:(id)sender {
    [self.scrollingTimer invalidate];
    self.scrollingTimer=nil;
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(500/self.speedSlider.value+0.500)
                                                               target:self selector:@selector(addAnimationToPoint) userInfo:nil repeats:YES];
    }
}
@end
