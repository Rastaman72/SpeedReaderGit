//
//  GraRiseViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/2/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GraRiseViewController.h"

@interface GraRiseViewController ()

@end

@implementation GraRiseViewController

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
    self.numberDic=[[NSMutableDictionary alloc]init];
    self.touchCounter=0;
    self.nextNumber=1;
    self.wrongChooseCounter=0;
    self.lineSize=5;
      self.positionX=100;
    self.squareSize=70;
    [self createSlider];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
    // Do any additional setup after loading the view.
}



-(void)checkOrientataion
{
    [self deviceOrientationDidChange:nil];
}


- (void)deviceOrientationDidChange:(NSNotification *)notification {
    //Obtain current device orientation
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(orientation==UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight)
    {
        if(!self.changePosition)
        {
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y-=50;
            toChangeGameView.size.height-=50;
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeSizeView= self.sizeView.frame;
            toChangeSizeView.origin.y-=225;
            [self.sizeView setFrame:toChangeSizeView];
            
            
            
            CGRect toChangetStartButton= self.startButton.frame;
            toChangetStartButton.origin.y-=225;
            [self.startButton setFrame:toChangetStartButton];
            
            self.squareSize-=20;
            self.positionX+=70;
            [self sizeChange:self];
             self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y+=50;
            toChangeGameView.size.height-=50;
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeSizeView= self.sizeView.frame;
            toChangeSizeView.origin.y+=225;
            [self.sizeView setFrame:toChangeSizeView];
            
            
            
            CGRect toChangetStartButton= self.startButton.frame;
            toChangetStartButton.origin.y+=225;
            [self.startButton setFrame:toChangetStartButton];
            
            self.squareSize+=20;
            self.positionX-=70;
            [self sizeChange:self];
            self.changePosition=NO;
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createSlider
{
    self.numberSize=[[NSArray alloc]init];
    self.numberSize = @[@(16), @(25), @(36)];
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numberSize count] - 1);
    self.sizeSlider.maximumValue = numberOfSteps;
    self.sizeSlider.minimumValue = 0;
    [self.sizeSlider setValue:1 animated:YES];
    
    //self.chooseSize=[[self.numberSize objectAtIndex:0]integerValue];
    //    self.chooseSize = [[[NSNumber alloc]initWithInt: [self.numberSize[0]intValue]]intValue];
    //    NSLog(@"%d",[[self.numberSize objectAtIndex:0]intValue]);
    self.chooseSize=[[self.numberSize objectAtIndex:1]intValue];
    // As the slider moves it will continously call the -valueChanged:
    self.sizeSlider.continuous = NO; // NO makes it call only once you let go
    [ self.sizeSlider addTarget:self
                         action:@selector(sizeChange:)
               forControlEvents:UIControlEventValueChanged];
    self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.chooseSize]description];
    self.lineSize=5;
    
}


-(void)createNumber
{
    for(int i=0;i<self.lineSize;i++)
    {
        for(int j=0;j<self.lineSize;j++)
        {
            // CGRect Rect= CGRectMake(0,0, 50, 50);
             CGRect Rect1= CGRectMake(self.positionX+i*self.squareSize,50+j*self.squareSize, self.squareSize, self.squareSize);
            
            CALayer* rectangleToAdd = [CALayer layer];
            [rectangleToAdd setFrame:Rect1];
            [rectangleToAdd setBounds:Rect1];
            [rectangleToAdd setCornerRadius:5.0f];
            [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setOpacity:1.0f];
            [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setBorderWidth:10.0f];
            
            [self.numberDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Number %d",i*self.lineSize+j]];
            }
    }
    
    
}
-(void)addNumberToObject
{
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    int i=0;
   
    
    
    int upperBound=self.chooseSize-1;
    
    
     while (upperBound>=0) {
        //  CALayer* singleLayer=[self.numberDic valueForKey:[NSString stringWithFormat:@"Number %d",i]];
        
        
        
        NSString* key=[allKeys objectAtIndex:arc4random_uniform(upperBound)];
        [allKeys removeObject:key];
        upperBound--;
    
   // for (NSString *key in allKeys)
   // {
        
        
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        
        CALayer* object = [self.numberDic objectForKey: key];
        CGRect Rect= object.frame;
        Rect.origin.y+=10;
        
        
        i++;
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:Rect];
        [label setString:[NSString stringWithFormat:@"%d",i]];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        [object addSublayer:label];
        [self.numberDic setObject:object forKey:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
        }
}

-(void)addObjectToLayer
{
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.numberDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
        [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
    }
}


- (IBAction)sizeChange:(id)sender {
    
    
    NSUInteger index = (NSUInteger)(self.sizeSlider.value + 0.5);
    [self.sizeSlider setValue:index animated:NO];
    NSNumber *number = self.numberSize[index]; // <-- This numeric value you want
    self.chooseSize=[number intValue];
    self.sizeCounterLabel.text=[number description];
    
    
    switch (self.chooseSize) {
        case 16:
            self.lineSize=4;
            break;
        case 25:
            self.lineSize=5;
            break;
        case 36:
           
            self.lineSize=6;
            break;
    
            
        default:
            break;
    }
    
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
    for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
    {
        if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
        {
            
            if([[[singleLayer.sublayers firstObject]string] isEqualToString:[NSString stringWithFormat:@"%d",self.nextNumber]])
            {
                NSLog(@"%@",singleLayer.sublayers );
                [singleLayer replaceSublayer:[singleLayer.sublayers objectAtIndex:0] with:nil];
                NSLog(@"%@",singleLayer.sublayers );
                
                CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
                flash.fromValue = [NSNumber numberWithFloat:0.0];
                flash.toValue = [NSNumber numberWithFloat:1.0];
                flash.duration = 0.5;
                flash.delegate=self;// 1 second
                flash.removedOnCompletion = YES;
               // flash.autoreverses = YES;    // Back
                
                [singleLayer addAnimation:flash forKey:@"flashAnimation"];
                self.touchCounter++;
                self.nextNumber++;
                
                }
           else
                self.wrongChooseCounter++;
        }
    }
    
            
        
        
   
    
}


- (IBAction)sizeDynamic:(id)sender {
}
- (IBAction)startPush:(id)sender {
      [self sizeChange:self];
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
