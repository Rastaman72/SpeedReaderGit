//
//  ZaznaczCoWystapiloViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "ZaznaczCoWystapiloViewController.h"

@interface ZaznaczCoWystapiloViewController ()

@end

@implementation ZaznaczCoWystapiloViewController

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
    [self createSlider];
    [self createObjects];
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
            toChangeGameView.size.height-=100;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeWordShowView= self.wordShowView.frame;
            toChangeWordShowView.origin.y-=225;
            [self.wordShowView setFrame:toChangeWordShowView];
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y-=225;
            [self.startButton setFrame:toChangeStartButton];
            
            CGRect toChangeAnswerButton= self.answerButton.frame;
            toChangeAnswerButton.origin.y-=225;
            [self.answerButton setFrame:toChangeAnswerButton];
            
            CGRect toChangeWordLengthView= self.wordLengthView.frame;
            toChangeWordLengthView.origin.y-=225;
            [self.wordLengthView setFrame:toChangeWordLengthView];
            
            CGRect toChangeNumbersOfLineView= self.numbersOfLineView.frame;
            toChangeNumbersOfLineView.origin.y-=225;
            [self.numbersOfLineView setFrame:toChangeNumbersOfLineView];

            
            
         
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y+=50;
            toChangeGameView.size.height+=100;
            [self.gameView setFrame:toChangeGameView];
            
            CGRect toChangeWordShowView= self.wordShowView.frame;
            toChangeWordShowView.origin.y+=225;
            [self.wordShowView setFrame:toChangeWordShowView];
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y+=225;
            [self.startButton setFrame:toChangeStartButton];
            
            CGRect toChangeAnswerButton= self.answerButton.frame;
            toChangeAnswerButton.origin.y+=225;
            [self.answerButton setFrame:toChangeAnswerButton];
            
            CGRect toChangeWordLengthView= self.wordLengthView.frame;
            toChangeWordLengthView.origin.y+=225;
            [self.wordLengthView setFrame:toChangeWordLengthView];
            
            CGRect toChangeNumbersOfLineView= self.numbersOfLineView.frame;
            toChangeNumbersOfLineView.origin.y+=225;
            [self.numbersOfLineView setFrame:toChangeNumbersOfLineView];

           
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
    
    self.numbersWordLength=[[NSMutableArray alloc]init];
    for (int i=3; i<10; i++) {
        [self.numbersWordLength addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numbersWordLength count] - 1);
    self.wordLengthSlider.maximumValue = numberOfSteps;
    self.wordLengthSlider.minimumValue = 0;
    [self.wordLengthSlider setValue:0 animated:YES];
    
    self.wordLength=[[self.numbersWordLength objectAtIndex:0]integerValue];
    // As the slider moves it will continously call the -valueChanged:
    self.wordLengthSlider.continuous = NO; // NO makes it call only once you let go
    [ self.wordLengthSlider addTarget:self
                               action:@selector(wordLengthChange:)
                     forControlEvents:UIControlEventValueChanged];
    self.wordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordLength]description];
    
    
    
    self.numbersOfLineArray=[[NSMutableArray alloc]init];
    for (int i=1; i<6; i++) {
        [self.numbersOfLineArray addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps1 = ((float)[self.numbersOfLineArray count] - 1);
    self.numbersOfLineSlider.maximumValue = numberOfSteps1;
    self.numbersOfLineSlider.minimumValue = 0;
    [self.numbersOfLineSlider setValue:0 animated:YES];
    
    self.lineNumbers=[[self.numbersOfLineArray objectAtIndex:0]integerValue];
    // As the slider moves it will continously call the -valueChanged:
    self.numbersOfLineSlider.continuous = NO; // NO makes it call only once you let go
    [ self.numbersOfLineSlider addTarget:self
                               action:@selector(numbersOfLineChange:)
                     forControlEvents:UIControlEventValueChanged];
    self.numbersOfLineCounterLabel.text=[[[NSNumber alloc]initWithInt:self.lineNumbers]description];
    self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowTimeSlider.value]description];
    

}

-(void)createObjects
{
    int bound;
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* textToDisplay=[[NSString alloc]init];
    self.goodAnswer=[[NSMutableArray alloc]init];
    self.tempList=[[NSMutableArray alloc]init];
    lowBound=arc4random_uniform(8);
    bound=lowBound+3;
    bool canUseThisValue;
    
    
    
    int numbersOfObjects=0;
    while (numbersOfObjects < self.lineNumbers+3)
    {
        canUseThisValue = true;
      
        for(int j=0;j<self.wordLength;j++)
        {
            rndValue= lowBound + arc4random() % (bound - lowBound);
            numValue=[[NSNumber alloc]initWithInt:rndValue];
            textToDisplay=[textToDisplay stringByAppendingString:[numValue stringValue]];
        }
        
        for (NSString* singleVale in self.tempList) {

            if ([textToDisplay isEqualToString: singleVale])
            {
                canUseThisValue = false;
                break;
            }
        }
        
        if (canUseThisValue == true)
        {
            [self.tempList addObject:textToDisplay];
            numbersOfObjects++;
            textToDisplay=[[NSString alloc]init];
        }
        textToDisplay=[[NSString alloc]init];
    }
    
    
    
    for (int i=0; i<self.lineNumbers+3; i++) {
     //  CALayer* singleLayer=[self.numberDic valueForKey:[NSString stringWithFormat:@"Number %d",i]];
        for(int j=0;j<self.wordLength;j++)
        {
            /*rndValue= lowBound + arc4random() % (bound - lowBound);
            numValue=[[NSNumber alloc]initWithInt:rndValue];
            textToDisplay=[textToDisplay stringByAppendingString:[numValue stringValue]];*/
            if(i<self.lineNumbers)
            {
            if(j==self.wordLength-1)
                [self.goodAnswer addObject:self.tempList[i]];
            }
            

        }
        textToDisplay=[[self.tempList objectAtIndex:i ]description];
        CGRect Rect1= CGRectMake(0+i*90,100, 85, 50);
        
               CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:16];
        [label setFrame:Rect1];
        [label setString:textToDisplay];
        textToDisplay=[[NSString alloc]init];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        
       
        [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i]];
        /* self.textLabel.textAlignment=NSTextAlignmentCenter;
         self.textLabel.text=
         textToDisplay;
         [self.textLabel sizeToFit];
         self.textLabel.center = CGPointMake(self.view.frame.size.width/2, 300);*/
    }
}

-(void)addObjectToLayer
{
    int i=0;
    int bound=0;
    if(!self.startPush)
    {
        bound=self.lineNumbers;
        //self.startPush=!self.startPush;
        
    }
    else
    {
        bound=self.lineNumbers+3;
        //self.startPush=!self.startPush;
    }
    
    {
        NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
       
       
        int upperBound=[allKeys count]-1;
       
        while (upperBound>=0) {
            
            NSString* key=[allKeys objectAtIndex:arc4random_uniform(upperBound)];
            [allKeys removeObject:key];
            upperBound--;
        
        //for (NSString *key in allKeys)
        //{
            
            CATextLayer* object = [self.numberDic objectForKey: key];
            NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
           
                CGRect Rect1= CGRectMake(0+i*90,100, 85, 50);
         
                [object setFrame:Rect1];
            [object setPosition:CGPointMake(Rect1.origin.x+Rect1.size.width/2, Rect1.origin.y+Rect1.size.height/2)];
                [self.numberDic setObject:object forKey:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
                 if ([[words lastObject]intValue]<bound) {
                    
                [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
               // [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
                 i++;
                
            }
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
    self.numberDic=[[NSMutableDictionary alloc]init];
    self.gameView.layer.sublayers=nil;
    
    [self createObjects];
    [self addObjectToLayer];
    [self.wordShowTimer invalidate];
    self.wordShowTimer = [NSTimer scheduledTimerWithTimeInterval:(self.wordShowTimeSlider.value/1000)
                                                          target:self selector:@selector(startGame) userInfo:nil repeats:NO];

    
    
}
- (IBAction)wordShowTimeChange:(id)sender {
    if(self.startPush)
    {
        [self.wordShowTimer invalidate];
        self.wordShowTimer = [NSTimer scheduledTimerWithTimeInterval:(self.wordShowTimeSlider.value/1000)
                                                               target:self selector:@selector(startGame) userInfo:nil repeats: NO];
        self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowTimeSlider.value]description];
    }
    
    self.wordShowTimeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordShowTimeSlider.value]description];

}

-(void)startGame
{
       /* CATextLayer *label = [[CATextLayer alloc] init];
    [label setFont:@"Helvetica-Bold"];
    [label setFontSize:16];
     CGRect Rect1= CGRectMake(75,100, 80, 50);
    [label setFrame:Rect1];
    [label setString:@"DUPCIA"];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[[UIColor blackColor] CGColor]];
    [self.gameView.layer addSublayer:label];*/
    self.gameView.layer.sublayers=nil;
    self.answerButton.hidden=NO;
    //[self addObjectToLayer];
}

- (IBAction)wordLengthChange:(id)sender {
    
    NSUInteger index = (NSUInteger)(self.wordLengthSlider.value + 0.5);
    [self.wordLengthSlider setValue:index animated:NO];
    NSNumber *number = self.numbersWordLength[index]; // <-- This numeric value you want
    self.wordLength=[number intValue];
    
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    self.wordLengthCounterLabel.text=[number description];
    self.gameView.layer.sublayers=nil;
    
    self.numberDic=[[NSMutableDictionary alloc]init];
    //[self createSlider];
    [self createObjects];
   // [self addObjectToLayer];
}
- (IBAction)numbersOfLineChange:(id)sender {
    
    NSUInteger index = (NSUInteger)(self.numbersOfLineSlider.value + 0.5);
    [self.numbersOfLineSlider setValue:index animated:NO];
    NSNumber *number = self.numbersOfLineArray[index]; // <-- This numeric value you want
    self.lineNumbers=[number intValue];
    
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    self.numbersOfLineCounterLabel.text=[number description];
    self.gameView.layer.sublayers=nil;
    
    self.numberDic=[[NSMutableDictionary alloc]init];
   // [self createSlider];
    [self createObjects];
   // [self addObjectToLayer];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
    for (CATextLayer* singleLayer in self.gameView.layer.sublayers)
    {
        //if(singleLayer.backgroundColor!=[[UIColor whiteColor]CGColor])
        //{
            
            if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
            {
                
                    NSString* test=singleLayer.string;
                for (NSString* singleAnswer in self.goodAnswer) {
                    
                
                        if ([test rangeOfString:singleAnswer].location != NSNotFound) {
                            
                                [singleLayer setBackgroundColor:[[UIColor greenColor]CGColor]];
                                [singleLayer setOpacity:1.0f];
                            
                            break;
                        }
                
                            else
                            {
                                [singleLayer setBackgroundColor:[[UIColor redColor]CGColor]];
                                [singleLayer setOpacity:1.0f];
                            }
                }
                
                
                        
                
            
            }
        //}
    }
    
}

- (IBAction)answerPush:(id)sender {
    self.startPush=!self.startPush;
    [self addObjectToLayer];
     self.startPush=!self.startPush;
      self.answerButton.hidden=YES;
}
@end
