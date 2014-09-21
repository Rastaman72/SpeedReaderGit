//
//  TabliceSchultzaKolejneLiczbyViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/6/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "TabliceSchultzaKolejneLiczbyViewController.h"

@interface TabliceSchultzaKolejneLiczbyViewController ()

@end

@implementation TabliceSchultzaKolejneLiczbyViewController

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
self.theDataObject = [self theAppDataObject];
    self.theDataObject = [self theAppDataObject];
    
    if (self.theDataObject.excMode) {
        
        [self createSlider];

    }
    else
    {
        
        if ([[self.theDataObject.paramsForSpecifyExc valueForKey:@"type"]isEqualToString:@"char"]) {
            self.mode=NO;
        }
        else
            self.mode=YES;
        self.squareSize=[[self.theDataObject.paramsForSpecifyExc valueForKey:@"size"]intValue];
               self.setModeView.hidden=YES;
        self.squareSizeView.hidden=YES;
        
    }
    self.numberDic=[[NSMutableDictionary alloc]init];
    self.objectSize=70;
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:   @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    [self checkOrientataion];
    // Do any additional setup after loading the view.
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
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
            toChangeGameView.origin.y-=125;
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeModeView= self.setModeView.frame;
            toChangeModeView.origin.y-=225;
            [self.setModeView setFrame:toChangeModeView];
            
            CGRect toChangeInfoView= self.infoView.frame;
            toChangeInfoView.origin.y-=225;
            [self.infoView setFrame:toChangeInfoView];
            
            
            CGRect toChangeSquareSizeView= self.squareSizeView.frame;
            toChangeSquareSizeView.origin.y-=225;
            [self.squareSizeView setFrame:toChangeSquareSizeView];
            
            
            self.objectSize-=20;
            
            self.gameView.layer.sublayers=nil;
            self.numberDic=[[NSMutableDictionary alloc]init];
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
            toChangeGameView.origin.y+=125;
            [self.gameView setFrame:toChangeGameView];
            
            
            CGRect toChangeModeView= self.setModeView.frame;
            toChangeModeView.origin.y+=225;
            [self.setModeView setFrame:toChangeModeView];
            
            CGRect toChangeInfoView= self.infoView.frame;
            toChangeInfoView.origin.y+=225;
            [self.infoView setFrame:toChangeInfoView];
            
            
            CGRect toChangeSquareSizeView= self.squareSizeView.frame;
            toChangeSquareSizeView.origin.y+=225;
            [self.squareSizeView setFrame:toChangeSquareSizeView];
            
            self.objectSize+=20;
            
            self.gameView.layer.sublayers=nil;
            self.numberDic=[[NSMutableDictionary alloc]init];
            [self createNumber];
            [self addNumberToObject];
            [self addObjectToLayer];

           
            self.changePosition=NO;
        }
    }
    
}

-(void)createSlider
{
    
    self.numbersSquareSize=[[NSMutableArray alloc]init];
    for (int i=3; i<7; i++) {
        [self.numbersSquareSize addObject:[[NSNumber alloc]initWithInt:pow(i, 2)]];
    }
    // slider values go from 0 to the number of values in your numbers array
    NSInteger numberOfSteps = ((float)[self.numbersSquareSize count] - 1);
    self.squareSizeSlider.maximumValue = numberOfSteps;
    self.squareSizeSlider.minimumValue = 0;
    [self.squareSizeSlider setValue:1 animated:YES];
    
    self.squareSize=[[self.numbersSquareSize objectAtIndex:1]integerValue];
    // As the slider moves it will continously call the -valueChanged:
    self.squareSizeSlider.continuous = NO; // NO makes it call only once you let go
    [ self.squareSizeSlider addTarget:self
                               action:@selector(squareSizeChange:)
                     forControlEvents:UIControlEventValueChanged];
    self.squareSizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.squareSize]description];

    
    
    
}
-(void)createNumber
{
    for(int i=0;i<sqrt(self.squareSize);i++)
    {
        for(int j=0;j<sqrt(self.squareSize);j++)
        {
            // CGRect Rect= CGRectMake(0,0, 50, 50);
            CGRect Rect1= CGRectMake(10+i*self.objectSize,10+j*self.objectSize, self.objectSize, self.objectSize);
            
            CALayer* rectangleToAdd = [CALayer layer];
            [rectangleToAdd setFrame:Rect1];
            [rectangleToAdd setBounds:Rect1];
            [rectangleToAdd setCornerRadius:5.0f];
            [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setOpacity:1.0f];
            [rectangleToAdd setBorderColor:[[UIColor redColor]CGColor]];
            [rectangleToAdd setBorderWidth:10.0f];
                    [self.numberDic setObject:rectangleToAdd forKey:[NSString stringWithFormat:@"Number %d",i*(int)sqrt(self.squareSize)+j]];
            
            // [self.numberDic setObject:label forKey:[NSString stringWithFormat:@"Number %d",i*self.horizontalSize+j]];
        }
    }
    
    
}


-(void)addNumberToObject
{
    NSNumber* numValue;
    NSString* textToDisplay=[[NSString alloc]init];
    NSString* letters=[[NSString alloc]init];
    
    NSMutableArray *allKeys = [[self.numberDic allKeys] mutableCopy];
    int upperBound=self.squareSize-1;

    
    for (int i=0; i<self.squareSize; i++) {
      //  CALayer* singleLayer=[self.numberDic valueForKey:[NSString stringWithFormat:@"Number %d",i]];
        
        
        
               NSString* key=[allKeys objectAtIndex:arc4random_uniform(upperBound)];
        [allKeys removeObject:key];
        upperBound--;
        CALayer* singleLayer=[self.numberDic objectForKey:key];
        
            
        i++;
                    numValue=[[NSNumber alloc]initWithInt:i];
                    
                    letters=[NSString stringWithFormat:@"%c",i+64];
        i--;
        
        
            if (self.mode) {
                textToDisplay=[textToDisplay stringByAppendingString:[numValue stringValue]];
            }
            else
                
                textToDisplay=[textToDisplay stringByAppendingString:letters];
      
        
        
        
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        CGRect rect= singleLayer.frame;
        rect.origin.x+=5;
        rect.origin.y+=5;
        [label setFrame:rect];
        [label setString:textToDisplay];
        textToDisplay=[[NSString alloc]init];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        
        [singleLayer addSublayer:label];
        //[self.numberDic setObject:singleLayer forKey:[NSString stringWithFormat:@"Number %d",i]];
        [self.numberDic setObject:singleLayer forKey:key];
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

- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;

    
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
}

- (IBAction)squareSizeChange:(id)sender {
    
    NSUInteger index = (NSUInteger)(self.squareSizeSlider.value + 0.5);
    [self.squareSizeSlider setValue:index animated:NO];
    NSNumber *number = self.numbersSquareSize[index]; // <-- This numeric value you want
    self.squareSize=[number intValue];
    
    NSLog(@"sliderIndex: %i", (int)index);
    NSLog(@"number: %@", number);
    
    self.squareSizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.squareSize]description];
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startPush:(id)sender {
    self.gameView.layer.sublayers=nil;
    self.numberDic=[[NSMutableDictionary alloc]init];
    [self createNumber];
    [self addNumberToObject];
    [self addObjectToLayer];
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
