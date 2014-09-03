//
//  GimnastykaOczuSzerokoscPolaWidzeniaViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GimnastykaOczuSzerokoscPolaWidzeniaViewController.h"
#define P(x,y) CGPointMake(x, y)
#define HALFSIZE object.frame.size.width/2

@interface GimnastykaOczuSzerokoscPolaWidzeniaViewController ()

@end

@implementation GimnastykaOczuSzerokoscPolaWidzeniaViewController

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
    for (int i=0; i<2; i++)
    {
        int horAdd;
        int verAdd;
        if (i<2) {
            horAdd=100*i;
            verAdd=0;
    
        CGRect Rect = CGRectMake(250+horAdd, 250+verAdd, 20, 20);
        CALayer *point = [CALayer layer];
        [point setFrame:Rect];
        [point setBounds:Rect];
        point.backgroundColor=[[UIColor greenColor]CGColor];
        switch (i) {
            case 0:
            {
                
                
                
                CATextLayer *label = [[CATextLayer alloc] init];
                [label setFont:@"Helvetica-Bold"];
                [label setFontSize:20];
                [label setFrame:Rect];
                [label setString:@"L"];
                [label setAlignmentMode:kCAAlignmentCenter];
                [label setForegroundColor:[[UIColor blackColor] CGColor]];
                [point addSublayer:label];
                
            }
                break;
                
            case 1:
            {
                
                CATextLayer *label = [[CATextLayer alloc] init];
                [label setFont:@"Helvetica-Bold"];
                [label setFontSize:20];
                [label setFrame:Rect];
                 [label setString:@"R"];
                [label setAlignmentMode:kCAAlignmentCenter];
                [label setForegroundColor:[[UIColor blackColor] CGColor]];
                [point addSublayer:label];
                
            }
                break;
            
            default:
                break;
        };
        [self.pointsArray setValue:point forKey:[NSString stringWithFormat:@"dot %d",i]];
        
    }
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
    
    if( self.animFinish==2)
        
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
            [trackPath addLineToPoint:P(midX-offset,midY)];

            break;
            
        case 1:
            [trackPath addLineToPoint:P(midX+offset,midY)];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startPush:(id)sender {

        if(!self.started)
        {
            if (self.scrollingTimer == nil)
            {
                self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(500/self.speedSlider.value+0.500)
                                                                       target:self selector:@selector(addAnimationToPoint) userInfo:nil repeats:YES];

            }
            self.started=!self.started;
        }
        else
        {
            self.started=!self.started;
            [self.scrollingTimer invalidate];
            self.scrollingTimer=nil;
        }
  
}
- (IBAction)speedChange:(id)sender {
    [self.scrollingTimer invalidate];
    self.scrollingTimer=nil;
    
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(500/self.speedSlider.value+0.500)
                                                               target:self selector:@selector(addAnimationToPoint) userInfo:nil repeats:YES];
    }
}
@end
