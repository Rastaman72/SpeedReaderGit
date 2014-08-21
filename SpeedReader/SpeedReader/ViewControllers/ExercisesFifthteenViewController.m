//
//  ExercisesFifthteenViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ExercisesFifthteenViewController.h"

@interface ExercisesFifthteenViewController ()

@end

@implementation ExercisesFifthteenViewController

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
    self.rectangleDic=[[NSMutableDictionary alloc] init];
    [self initFrames];
    [self addFrameToView];
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                               target:self selector:@selector(resizeRectangular) userInfo:nil repeats:YES];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initFrames
{
    int width=self.view.frame.size.width/4;
    int heigth =150;
    int midX=(self.view.frame.size.width -width)*0.5f;
    int midY=(500 -heigth)*0.5f-150;

    self.upperBand=width*1.5f;
    for (int i=0;i<3; i++) {
        
        if (i==2) {
            width=0;
            heigth=0;
        }
        CGRect Rect= CGRectMake(midX,midY, width, heigth);
        CALayer* rectangleToAdd = [CALayer layer];

        [rectangleToAdd setFrame:Rect];
        [rectangleToAdd setBounds:Rect];
        [rectangleToAdd setCornerRadius:5.0f];
        
        switch (i) {
            case 0:
                [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
                [rectangleToAdd setOpacity:0.2f];
                [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
                [rectangleToAdd setBorderWidth:10.0f];

                break;
            case 1:
                [rectangleToAdd setBackgroundColor:[[UIColor blueColor]CGColor]];
                [rectangleToAdd setOpacity:0.2f];
                [rectangleToAdd setBorderColor:[[UIColor blueColor]CGColor]];
                [rectangleToAdd setBorderWidth:10.0f];
                
                break;
            case 2:
                [rectangleToAdd setBackgroundColor:[[UIColor yellowColor]CGColor]];
                [rectangleToAdd setOpacity:0.2f];
                [rectangleToAdd setBorderColor:[[UIColor yellowColor]CGColor]];
                [rectangleToAdd setBorderWidth:10.0f];
                
                break;
            default:
                break;
        }
        
        [self.rectangleDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Rectangle %d",i]];
       
        width=width*0.5f;
        heigth=heigth*0.5f;
        
        if (i==2) {
            width=0;
            heigth=0;
        }
        
        midX=(self.view.frame.size.width -width)*0.5f;
        midY=(500 -heigth)*0.5f-150;
     
    }
}

-(void)createFrame:(int)selectFrame
{
    int offset=5;
    
    CGRect Rect;
    CALayer* toTestRect=[self.rectangleDic objectForKey:[NSString stringWithFormat:@"Rectangle %d",selectFrame]];
    
    int width=0;
    int heigth =0;
    int midX=0;
    int midY=0;
    if(toTestRect.frame.size.width>self.upperBand)
        {
            width=0;
            heigth =0;
            midX=(self.view.frame.size.width -width)*0.5f;
            midY=(500 -heigth)*0.5f-150;
            Rect= CGRectMake(midX,midY, width,heigth);
        }
        else
        {
            width=toTestRect.frame.size.width+offset*2;
            heigth =toTestRect.frame.size.height+offset*2;
            midX=(self.view.frame.size.width -width)*0.5f;
            midY=(500 -heigth)*0.5f-150;
            Rect= CGRectMake(midX,midY, width, heigth);
            
        }
        CALayer* rectangleToAdd = [CALayer layer];
    
        switch (selectFrame) {
            case 0:
                [rectangleToAdd setFrame:Rect];
                [rectangleToAdd setBounds:Rect];
                [rectangleToAdd setCornerRadius:5.0f];
                [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
                [rectangleToAdd setOpacity:0.2f];
                [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
                [rectangleToAdd setBorderWidth:5.0f];
                
                break;
            case 1:
                [rectangleToAdd setFrame:Rect];
                [rectangleToAdd setBounds:Rect];
                [rectangleToAdd setCornerRadius:5.0f];
                [rectangleToAdd setBackgroundColor:[[UIColor blueColor]CGColor]];
                [rectangleToAdd setOpacity:0.2f];
                [rectangleToAdd setBorderColor:[[UIColor blueColor]CGColor]];
                [rectangleToAdd setBorderWidth:5.0f];
                
                break;
            case 2:
                [rectangleToAdd setFrame:Rect];
                [rectangleToAdd setBounds:Rect];
                [rectangleToAdd setCornerRadius:5.0f];
                [rectangleToAdd setBackgroundColor:[[UIColor yellowColor]CGColor]];
                [rectangleToAdd setOpacity:0.2f];
                [rectangleToAdd setBorderColor:[[UIColor yellowColor]CGColor]];
                [rectangleToAdd setBorderWidth:5.0f];
                
                break;
            default:
                break;
        
                
    }
    
    [self.rectangleDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Rectangle %d",selectFrame]];
    

}

-(void)addFrameToView
{
    NSMutableArray *allKeys = [[self.rectangleDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.rectangleDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        [self.view.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
    }
}

-(void)resizeRectangular
{
    for (int i=0; i<3; i++) {
        
   
    [self createFrame:i];
     }
    
    NSMutableArray *allKeys = [[self.rectangleDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.rectangleDic objectForKey: key];
        
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        
        [self.view.layer replaceSublayer:[self.view.layer.sublayers objectAtIndex:[[words lastObject]intValue]] with:object];
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
