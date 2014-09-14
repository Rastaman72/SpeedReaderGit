//
//  ZaznaczCiagiViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ZaznaczCiagiViewController.h"

@interface ZaznaczCiagiViewController ()

@end

@implementation ZaznaczCiagiViewController

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
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    self.startPushed=NO;
    self.objectSize=60;
   [self createGoodAnswer];
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
            toChangeGameView.origin.y-=10;
              toChangeGameView.size.height-=100;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y-=225;
            [self.setModeView setFrame:toChangeSetModeView];

            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y-=225;
            [self.startButton setFrame:toChangeStartButton];

            
            CGRect toChangeWordLengthView= self.wordLengthView.frame;
            toChangeWordLengthView.origin.y-=225;
            [self.wordLengthView setFrame:toChangeWordLengthView];

            self.objectSize-=15;
            self.startPushed=NO;
            self.gameView.layer.sublayers=nil;
            self.numberDic=[[NSMutableDictionary alloc]init];
            self.goodAnswerCounter=0;
            self.goodAnswer=nil;
            [self createGoodAnswer];
            [self createNumber];
            [self addNumberToObject];
            [self addObjectToLayer];
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y+=10;
              toChangeGameView.size.height+=100;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y+=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y+=225;
            [self.startButton setFrame:toChangeStartButton];
            
            
            CGRect toChangeWordLengthView= self.wordLengthView.frame;
            toChangeWordLengthView.origin.y+=225;
            [self.wordLengthView setFrame:toChangeWordLengthView];
            
            self.objectSize+=15;
            self.startPushed=NO;
            self.gameView.layer.sublayers=nil;
            self.numberDic=[[NSMutableDictionary alloc]init];
            self.goodAnswerCounter=0;
            self.goodAnswer=nil;
            [self createGoodAnswer];
            [self createNumber];
            [self addNumberToObject];
            [self addObjectToLayer];
            self.changePosition=NO;
        }
    }
    
}
-(void)createGoodAnswer
{
    if(self.mode)
    {
    self.goodAnswer=[[NSString alloc]initWithFormat:@"%d",arc4random_uniform(10)];
    }
    else
    {
        self.goodAnswer=[[NSString alloc]initWithFormat:@"%c",arc4random_uniform(26)+97];
    }

}

-(void)createSlider
{
    self.numbersWordLength=[[NSMutableArray alloc]init];
    for (int i=2; i<5; i++) {
        [self.numbersWordLength addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numbersWordLength count] - 1);
    self.wordLengthSlider.maximumValue = numberOfSteps;
    self.wordLengthSlider.minimumValue = 0;
    [self.wordLengthSlider setValue:0 animated:YES];
    self.wordSize=[[self.numbersWordLength objectAtIndex:0]integerValue];
    
    // As the slider moves it will continously call the -valueChanged:
    self.wordLengthSlider.continuous = NO; // NO makes it call only once you let go
    [ self.wordLengthSlider addTarget:self
                               action:@selector(wordLengthChange:)
                     forControlEvents:UIControlEventValueChanged];
  
    
    
}

-(void)createNumber
{
    
    CATextLayer *label = [[CATextLayer alloc] init];
    [label setFont:@"Helvetica-Bold"];
    [label setFontSize:16];
    CGRect rect= CGRectMake(10,10, 400, 20);
    [label setFrame:rect];
    [label setString:[NSString stringWithFormat:@"Find symbol %@",self.goodAnswer]];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[[UIColor blackColor] CGColor]];
    [label setBackgroundColor:[[UIColor whiteColor]CGColor]];
    [label setOpacity:1.0f];

    [self.gameView.layer addSublayer:label];
    
       for(int i=0;i<8;i++)
    {
        for(int j=0;j<8;j++)
        {
            CGRect Rect1= CGRectMake(50+i*self.objectSize,50+j*self.objectSize, self.objectSize, self.objectSize);
            
            CALayer* rectangleToAdd = [CALayer layer];
            [rectangleToAdd setFrame:Rect1];
            [rectangleToAdd setBounds:Rect1];
            [rectangleToAdd setCornerRadius:5.0f];
            [rectangleToAdd setBackgroundColor:[[UIColor clearColor]CGColor]];
            [rectangleToAdd setOpacity:1.0f];
            [rectangleToAdd setBorderColor:[[UIColor clearColor]CGColor]];
            [rectangleToAdd setBorderWidth:10.0f];
            
            [self.numberDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Number %d",i*8+j]];
        }
    }
    
    
}

-(void)addNumberToObject
{
    int bound;
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* textToDisplay=[[NSString alloc]init];
    NSString* letters=[[NSString alloc]init];
    
    for (int i=0; i<64; i++) {
        CALayer* singleLayer=[self.numberDic valueForKey:[NSString stringWithFormat:@"Number %d",i]];
        for (int j=0; j<self.wordSize; j++) {
            
                    if(self.mode)
                    {
                        bound=10;
                        lowBound=bound/10;
                       
                    }
                    else
                    {
                        bound=26;
                        lowBound=1;
                    }
                    rndValue= lowBound + arc4random() % (bound - lowBound);
                    numValue=[[NSNumber alloc]initWithInt:rndValue];
                    
                    letters=[NSString stringWithFormat:@"%c",[numValue intValue]+96];
                    
            
            if (self.mode) {
                textToDisplay=[textToDisplay stringByAppendingString:[numValue stringValue]];
            }
            else
                
                textToDisplay=[textToDisplay stringByAppendingString:letters];
        }
        
        
        
        if ([textToDisplay rangeOfString:[self.goodAnswer description]].location != NSNotFound) {
            self.goodAnswerCounter++;
        }
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:16];
        CGRect rect= singleLayer.frame;
        rect.origin.x+=5;
        rect.origin.y+=5;
        [label setFrame:rect];
        [label setString:textToDisplay];
        textToDisplay=[[NSString alloc]init];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        
        [singleLayer addSublayer:label];
        [self.numberDic setObject:singleLayer forKey:[NSString stringWithFormat:@"Number %d",i]];
        /* self.textLabel.textAlignment=NSTextAlignmentCenter;
         self.textLabel.text=textToDisplay;
         [self.textLabel sizeToFit];
         self.textLabel.center = CGPointMake(self.view.frame.size.width/2, 300);*/
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

- (IBAction)wordLengthChange:(id)sender {
    NSUInteger index = (NSUInteger)(self.wordLengthSlider.value + 0.5);
    [self.wordLengthSlider setValue:index animated:NO];
    NSNumber *number = self.numbersWordLength[index]; // <-- This numeric value you want
    self.wordSize=[number intValue];
    
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    self.startPushed=NO;
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    self.goodAnswerCounter=0;
    self.goodAnswer=nil;
    [self createGoodAnswer];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
}

- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.gameView.layer.sublayers=nil;
    
    self.startPushed=NO;
    self.numberDic=[[NSMutableDictionary alloc]init];
    self.goodAnswerCounter=0;
    self.goodAnswer=nil;
    [self createGoodAnswer];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
    for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
    {
        if(singleLayer.backgroundColor!=[[UIColor whiteColor]CGColor])
        {
            
            if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
            {
                
                [singleLayer setBackgroundColor:[[UIColor yellowColor]CGColor]];
                
            }
        }
    }
    
}

- (IBAction)startPush:(id)sender {
    
    if(self.startPushed)
    {
        self.gameView.layer.sublayers=nil;
        self.numberDic=[[NSMutableDictionary alloc]init];
        self.goodAnswerCounter=0;
        self.goodAnswer=nil;
        [self createGoodAnswer];
        [self createNumber];
        [self addNumberToObject];
        [self addObjectToLayer];
    }
    else
    {
        for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
        {
            if (singleLayer.backgroundColor!=[[UIColor whiteColor]CGColor]) {
                
            
            NSString* test=[[singleLayer.sublayers firstObject]string];
            
            if ([test rangeOfString:[self.goodAnswer description]].location != NSNotFound) {
                if (singleLayer.backgroundColor==[[UIColor yellowColor]CGColor]) {
                    
                    [singleLayer setBackgroundColor:[[UIColor greenColor]CGColor]];
                    [singleLayer setOpacity:1.0f];
                    
                }
                else
                {
                    [singleLayer setBackgroundColor:[[UIColor redColor]CGColor]];
                    [singleLayer setOpacity:1.0f];
                }
            }
            else
            {
                
                [singleLayer setBackgroundColor:[[UIColor clearColor]CGColor]];
                [singleLayer setOpacity:1.0f];
            }
            
        }
        }
        
    }
    self.startPushed=!self.startPushed;
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
