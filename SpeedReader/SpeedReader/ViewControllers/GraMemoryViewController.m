//
//  ExercisesNinthteenViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/21/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "GraMemoryViewController.h"

@interface GraMemoryViewController ()

@end

@implementation GraMemoryViewController

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
    self.keyToDelete=[[NSMutableDictionary alloc]init];
    self.touchCounter=0;
    self.horizontalSize=6;
    self.verticalSize=6;
    self.squareSize=70;
    self.positionX=100;
    //self.gameView.layer.sublayers=nil;
    self.randomValueArray=[[NSMutableArray alloc]init];
    [self createSlider];
    [self createRandomValue];
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

-(void)createSlider
{
    self.numberSize=[[NSArray alloc]init];
    self.numberSize = @[@(12), @(16), @(20), @(36), @(64)];
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numberSize count] - 1);
    self.sizeSlider.maximumValue = numberOfSteps;
    self.sizeSlider.minimumValue = 0;
    [self.sizeSlider setValue:3 animated:YES];
    
    //self.chooseSize=[[self.numberSize objectAtIndex:0]integerValue];
//    self.chooseSize = [[[NSNumber alloc]initWithInt: [self.numberSize[0]intValue]]intValue];
//    NSLog(@"%d",[[self.numberSize objectAtIndex:0]intValue]);
    self.chooseSize=[[self.numberSize objectAtIndex:3]intValue];
    // As the slider moves it will continously call the -valueChanged:
    self.sizeSlider.continuous = NO; // NO makes it call only once you let go
    [ self.sizeSlider addTarget:self
                              action:@selector(sizeChange:)
                    forControlEvents:UIControlEventValueChanged];
    self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.chooseSize]description];
   
    
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
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeSizeView= self.sizeView.frame;
            toChangeSizeView.origin.y-=205;
            [self.sizeView setFrame:toChangeSizeView];
            
            
        
            CGRect toChangetStartButton= self.startButton.frame;
            toChangetStartButton.origin.y-=205;
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
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeSizeView= self.sizeView.frame;
            toChangeSizeView.origin.y+=205;
            [self.sizeView setFrame:toChangeSizeView];
            
            
            
            CGRect toChangetStartButton= self.startButton.frame;
            toChangetStartButton.origin.y+=205;
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
-(void)createRandomValue
{
    self.randomValueArray=[[NSMutableArray alloc]init];
    for (int i=0; i<(self.horizontalSize*self.verticalSize)/2; i++) {
        [self.randomValueArray addObject: [[NSNumber alloc ]initWithInt:arc4random_uniform(100)]];
    }
   

}

-(void)createNumber
{
    for(int i=0;i<self.horizontalSize;i++)
    {
        for(int j=0;j<self.verticalSize;j++)
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
        
        [self.numberDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Number %d",i*self.horizontalSize+j]];

        }
    }
    
    
}

-(void)addNumberToObject
{
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    int i=0;
    int j=0;
    for (NSString *key in allKeys)
    {
       
       
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];

        CALayer* object = [self.numberDic objectForKey: key];
        CGRect Rect= CGRectMake(0,0, self.squareSize, self.squareSize);

        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:object.frame];
        [label setString:[NSString stringWithFormat:@"%@", [self.randomValueArray objectAtIndex:j]]];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        [object setFrame:Rect];
        [object setBounds:Rect];
        
         [label addSublayer:object];
        [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];

        if (i==1) {
            j++;
            i=0;
            continue;
        }
        i++;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.touchCounter==2)
    {
        
        NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
        for (NSString *key in allKeys)
        {
            
            CGRect Rect= CGRectMake(0,0, self.squareSize, self.squareSize);
            CALayer* rectangleToAdd = [CALayer layer];
            [rectangleToAdd setFrame:Rect];
            [rectangleToAdd setBounds:Rect];
            [rectangleToAdd setCornerRadius:5.0f];
            [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setOpacity:1.0f];
            [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setBorderWidth:10.0f];
            
            CATextLayer* object = [self.numberDic objectForKey: key];
            
            if([object.sublayers objectAtIndex:0]==nil)
            [object addSublayer:rectangleToAdd];
            
        }
        self.touchCounter=0;
    
    }
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
    for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
    {
        if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
        {
            CATextLayer* object = [self.numberDic objectForKey: self.firstObjectToDelete];

            if(object!=singleLayer)
            {
           
            [singleLayer replaceSublayer:[singleLayer.sublayers objectAtIndex:0] with:nil];
        
            self.touchCounter++;
           
            
            NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
            for (NSString *key in allKeys)
            {
                
                CATextLayer* object = [self.numberDic objectForKey: key];
                if(object==singleLayer && (self.touchCounter==1 || self.touchCounter==2))
                {
                    if(self.firstObjectToDelete)
                        self.secondObjectToDelete=key;
                    else
                        self.firstObjectToDelete=key;
                }
                
            }
            }
            if(self.touchCounter==2)
            {
                    CATextLayer* layer = [self.gameView.layer valueForKey:self.firstObjectToDelete];
                    CATextLayer* layer1 = [self.gameView.layer valueForKey:self.secondObjectToDelete];

                    if([layer1.string isEqualToString:layer.string]){
                    
                    [layer removeFromSuperlayer];
                    [layer1 removeFromSuperlayer];

                    [self.gameView.layer setValue:nil forKey:self.firstObjectToDelete];
                        [self.gameView.layer setValue:nil forKey:self.secondObjectToDelete];

                    [self.numberDic removeObjectForKey:self.firstObjectToDelete];
                          [self.numberDic removeObjectForKey:self.secondObjectToDelete];

                }
                self.firstObjectToDelete=nil;
                self.secondObjectToDelete=nil;

            }
            
        
         break;}
    
    
    }
    
}

- (IBAction)sizeChange:(id)sender {
    
    NSUInteger index = (NSUInteger)(self.sizeSlider.value + 0.5);
    [self.sizeSlider setValue:index animated:NO];
    NSNumber *number = self.numberSize[index]; // <-- This numeric value you want
    self.chooseSize=[number intValue];
    self.sizeCounterLabel.text=[number description];

    
    switch (self.chooseSize) {
        case 12:
            self.horizontalSize=4;
            self.verticalSize=3;
           
            break;
        case 16:
            self.horizontalSize=4;
            self.verticalSize=4;
            break;
        case 20:
            self.horizontalSize=5;
            self.verticalSize=4;
            break;
        case 36:
            self.horizontalSize=6;
            self.verticalSize=6;
            break;
            
        case 64:
            self.horizontalSize=8;
            self.verticalSize=8;
            break;
            
            
        default:
            break;
    }
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    self.randomValueArray=[[NSMutableArray alloc]init];
    [self createRandomValue];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    
}

- (IBAction)sizeDynamic:(id)sender {
}
- (IBAction)startPush:(id)sender {
    [self sizeChange:self];
    

}
@end
