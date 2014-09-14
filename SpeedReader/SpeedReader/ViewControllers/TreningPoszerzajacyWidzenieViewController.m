//
//  TreningPoszerzajacyWidzenieViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/9/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "TreningPoszerzajacyWidzenieViewController.h"
#define P(x,y) CGPointMake(x, y)
#define HALFSIZE object.frame.size.width/2
@interface TreningPoszerzajacyWidzenieViewController ()

@end

@implementation TreningPoszerzajacyWidzenieViewController

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
    self.objectDic=[[NSMutableDictionary alloc]init];
    self.xmlManager=[self theAppDataObject];
    self.mode=self.selectModeSwitch;
    self.forward=YES;
    [self createSlider];
    [self createNumber];
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
            
            CGRect toChangeNumbersOfLineView= self.numbersOfLineView.frame;
            toChangeNumbersOfLineView.origin.y+=225;
            [self.numbersOfLineView setFrame:toChangeNumbersOfLineView];

            
            self.changePosition=NO;
        }
    }
    
}
-(void)createSlider
{
    self.numbersOfLinesArray=[[NSMutableArray alloc]init];
    for (int i=1; i<5; i++) {
        [self.numbersOfLinesArray addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numbersOfLinesArray count] - 1);
    self.numbersOfLineSlider.maximumValue = numberOfSteps;
    self.numbersOfLineSlider.minimumValue = 0;
    [self.numbersOfLineSlider setValue:0 animated:YES];
    self.numbersOfLine=[[self.numbersOfLinesArray objectAtIndex:0]integerValue];
    
    // As the slider moves it will continously call the -valueChanged:
    self.numbersOfLineSlider.continuous = NO; // NO makes it call only once you let go
    [ self.numbersOfLineSlider addTarget:self
                                  action:@selector(numbersOfLineChange:)
                        forControlEvents:UIControlEventValueChanged];
    
    self.numbersOfLineCounterLabel.text=[[[NSNumber alloc]initWithInt:self.numbersOfLine ] description];
    
    
    self.numbersWordLengthArray=[[NSMutableArray alloc]init];
    for (int i=1; i<11; i++) {
        [self.numbersWordLengthArray addObject:[[NSNumber alloc]initWithInt:i]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps1 = ((float)[self.numbersWordLengthArray count] - 1);
    self.wordLengthSlider.maximumValue = numberOfSteps1;
    self.wordLengthSlider.minimumValue = 0;
    [self.wordLengthSlider setValue:0 animated:YES];
    self.wordLength=[[self.numbersWordLengthArray objectAtIndex:0]integerValue];
    
    // As the slider moves it will continously call the -valueChanged:
    self.wordLengthSlider.continuous = NO; // NO makes it call only once you let go
    [ self.wordLengthSlider addTarget:self
                                  action:@selector(wordLengthChange:)
                        forControlEvents:UIControlEventValueChanged];
    
    self.wordLengthCounterLabel.text=[[[NSNumber alloc]initWithInt:self.wordLength ] description];
}

-(void)createNumber
{
    NSString* textToDisplay=[[NSString alloc]init];
    int bound=self.numbersOfLine;

   // if(self.numbersOfLine==1)
     //   bound=1;
     int upperBound;
    int lowBound = 0;
    int rndValue;
    int actualPosition=0;
    CGRect Rect1;
     NSNumber* numValue;
    if (self.mode) {
        for (int i=0; i<self.numbersOfLine*2; i++) {
            
            for (int j=0; j<self.wordLength; j++) {
                
                
                upperBound=10;
                lowBound=bound/10;
                
                rndValue= lowBound + arc4random() % (upperBound - lowBound);
                numValue=[[NSNumber alloc]initWithInt:rndValue];
                
                
                textToDisplay=[textToDisplay stringByAppendingString:[numValue description]];
            }
            if(i<bound)
            {
                Rect1= CGRectMake(10,30+actualPosition*20, 150, 30);
                actualPosition++;
                
            }
            else if(i==bound)
            {
                actualPosition=0;
                Rect1= CGRectMake(100,30+actualPosition*20, 150, 30);
                actualPosition++;
            }
            else
            {
                Rect1= CGRectMake(100,30+actualPosition*20, 150, 30);
                actualPosition++;
            }
            
            
            CATextLayer *label = [[CATextLayer alloc] init];
            [label setFont:@"Helvetica-Bold"];
            [label setFontSize:20];
            [label setFrame:Rect1];
            [label setString:textToDisplay];
            textToDisplay=[[NSString alloc]init];
            [label setAlignmentMode:kCAAlignmentCenter];
            [label setForegroundColor:[[UIColor blackColor] CGColor]];
            
            [self.objectDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i]];
            
        }
     }
    
    else{
        for (int i=0; i<self.numbersOfLine*2; i++) {
            
          
            if(self.wordLength<3)
            {
                for (int j=0; j<self.wordLength; j++) {

                upperBound=26;
                lowBound=1;
                
                rndValue= lowBound + arc4random() % (upperBound - lowBound);
                numValue=[[NSNumber alloc]initWithInt:rndValue];
                
                 textToDisplay=[textToDisplay stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
            }
            }
            
                else
            textToDisplay=[textToDisplay stringByAppendingString:[self.xmlManager getWord:self.wordLength]];
            
                if(i<bound)
                {
                    Rect1= CGRectMake(0,30+actualPosition*20, 150, 30);
                    actualPosition++;
                    
                }
                else if(i==bound)
                {
                    actualPosition=0;
                    Rect1= CGRectMake(70+[textToDisplay length]*5,30+actualPosition*20, 150, 30);
                    actualPosition++;
                }
                else
                {
                    Rect1= CGRectMake(70+[textToDisplay length]*5,30+actualPosition*20, 150, 30);
                    actualPosition++;
                }
            
            CATextLayer *label = [[CATextLayer alloc] init];
            [label setFont:@"Helvetica-Bold"];
            [label setFontSize:20];
            [label setFrame:Rect1];
            [label setString:textToDisplay];
            textToDisplay=[[NSString alloc]init];
            [label setAlignmentMode:kCAAlignmentCenter];
            [label setForegroundColor:[[UIColor blackColor] CGColor]];
            
            
           [self.objectDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i]];
            
    }
    }
   }

- (void)addAnimationToPoint//:(int)i point:(CALayer *)point
{
    NSLog(@"%@",@"animacja dodana");
    NSLog(@"%d",self.round);
    NSMutableArray *allKeys = [[self.objectDic allKeys] mutableCopy];
    self.animFinish=0;
    
    if(self.round==Finish)
    {
        if(self.increaseDistance>=3)
            self.increaseDistance=0;
        else
            self.increaseDistance++;
    }
    
    
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.objectDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        UIBezierPath *trackPath;
        trackPath = [self createForwardPath:object i:[[words lastObject]intValue] forward:self.forward increaseOffset:self.increaseDistance*10];
        
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        anim.path = trackPath.CGPath;
        anim.duration = 0.2;
        NSLog(@"%f",anim.duration);
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        anim.delegate=self;
        [object addAnimation:anim forKey:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
        [self.objectDic setValue:object forKey:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
        self.animFinish++;
    }
    
    if( self.animFinish==2*self.numbersOfLine)
        
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
    int bound=self.numbersOfLine;
    int side=0;
    
    if (i<bound) {
        side=0;
    }
    else
        side=1;
    [trackPath moveToPoint:P(midX, midY)];
    
    switch (side) {
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
    self.animFinish++;
    NSMutableArray *allKeys = [[self.objectDic allKeys] mutableCopy];
    
    for (id key in allKeys)
    {
        CALayer* object = [self.objectDic objectForKey: key];
        CAKeyframeAnimation* test=[object animationForKey:key];
        CGRect newFrame;
        CGPoint currentPosition = [[object presentationLayer] position];
        if (anim==test)
        {
            newFrame=CGRectMake(currentPosition.x-HALFSIZE, currentPosition.y-HALFSIZE, object.frame.size.width, object.frame.size.width);
            [object setFrame:newFrame];
            [object setBounds:[[object presentationLayer] bounds]];
            [self.objectDic setObject:object forKey:key];
            
        }
    }
}

-(void)addObjectToLayer
{
    NSMutableArray *allKeys = [[self.objectDic allKeys] mutableCopy];
    for (NSString *key in allKeys)
    {
        CALayer* object = [self.objectDic objectForKey: key];
        NSMutableArray* words=[[NSMutableArray alloc]initWithArray:[key componentsSeparatedByString:@" "]];
        [self.gameView.layer insertSublayer:object atIndex:[[words lastObject]intValue]];
        [self.gameView.layer setValue:object forKeyPath:[NSString stringWithFormat:@"Number %d",[[words lastObject]intValue]]];
    }
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (IBAction)numbersOfLineChange:(id)sender {
    NSUInteger index = (NSUInteger)(self.numbersOfLineSlider.value + 0.5);
    [self.numbersOfLineSlider setValue:index animated:NO];
    NSNumber *number = self.numbersOfLinesArray[index]; // <-- This numeric value you want
    self.numbersOfLine=[number intValue];
    self.numbersOfLineCounterLabel.text=[number description];
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    self.gameView.layer.sublayers=nil;
    self.objectDic=[[NSMutableDictionary alloc]init];
    self.xmlManager=[self theAppDataObject];
    [self createNumber];
    [self addObjectToLayer];
    [self.moveObjects invalidate];
    self.moveObjects=nil;
    self.started=NO;
    self.forward=YES;
    self.itWasBack=NO;
}


-(IBAction)wordLengthChange:(id)sender
{
    NSUInteger index = (NSUInteger)(self.wordLengthSlider.value + 0.5);
    [self.wordLengthSlider setValue:index animated:NO];
    NSNumber *number = self.numbersWordLengthArray[index]; // <-- This numeric value you want
    self.wordLength=[number intValue];
    self.wordLengthCounterLabel.text=[number description];
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    self.gameView.layer.sublayers=nil;
    self.objectDic=[[NSMutableDictionary alloc]init];
    self.xmlManager=[self theAppDataObject];
    [self createNumber];
    [self addObjectToLayer];
    
    [self.moveObjects invalidate];
    self.moveObjects=nil;
    self.started=NO;
    self.forward=YES;
    self.itWasBack=NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.gameView.layer.sublayers=nil;
    self.objectDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addObjectToLayer];
    
    [self.moveObjects invalidate];
    self.moveObjects=nil;
    self.started=NO;
    self.forward=YES;
    self.itWasBack=NO;
    
    
}

- (IBAction)startPush:(id)sender {
        if(!self.started)
    {
        if (self.moveObjects == nil)
        {
            
            self.gameView.layer.sublayers=nil;
            self.objectDic=[[NSMutableDictionary alloc]init];
            [self createNumber];
            [self addObjectToLayer];
            
            [self.moveObjects invalidate];
            self.moveObjects=nil;
            self.forward=YES;
            self.itWasBack=NO;

            
    self.moveObjects = [NSTimer scheduledTimerWithTimeInterval:(0.5)
                                                          target:self selector:@selector(addAnimationToPoint) userInfo:nil repeats:YES];
        }
    }
        else
        {
            [self.moveObjects invalidate];
            self.moveObjects=nil;
            

        }
    self.started=!self.started;

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.moveObjects invalidate];
    self.moveObjects=nil;
    

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
