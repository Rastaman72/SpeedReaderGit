//
//  ExercisesTwentyNineViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/24/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SzukanieSekwencjiWPiramidzieViewController.h"

@interface SzukanieSekwencjiWPiramidzieViewController ()

@end

@implementation SzukanieSekwencjiWPiramidzieViewController

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
    
    if (self.theDataObject.excMode) {
        
        self.actuallSize=(int)self.sizeSlider.value;
        self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.sizeSlider.value]description];
        

    }
    else
    {
        
        if ([[self.theDataObject.paramsForSpecifyExc valueForKey:@"type"]isEqualToString:@"char"]) {
            self.mode=NO;
        }
        else
            self.mode=YES;
        self.setModeView.hidden=YES;
        self.sizeView.hidden=YES;
        self.actuallSize=[[self.theDataObject.paramsForSpecifyExc valueForKey:@"wordlength"]intValue];
        
    }
    self.mode=NO;
    self.positionY=100;
       self.toFind=[[NSString alloc]init];
    [self create];
    [self createButtons];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y-=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y-=225;
            [self.startButton setFrame:toChangeStartButton];

            
            CGRect toChangeSizeView= self.sizeView.frame;
            toChangeSizeView.origin.y-=225;
            [self.sizeView setFrame:toChangeSizeView];
            
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y-=175;
            [self.gameView setFrame:toChangeGameView];


            
            
          
            
      
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y+=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            
            
            CGRect toChangeStartButton= self.startButton.frame;
            toChangeStartButton.origin.y+=225;
            [self.startButton setFrame:toChangeStartButton];
            
            
            CGRect toChangeSizeView= self.sizeView.frame;
            toChangeSizeView.origin.y+=225;
            [self.sizeView setFrame:toChangeSizeView];
            
            CGRect toChangeGameView= self.gameView.frame;
            toChangeGameView.origin.y+=175;
            [self.gameView setFrame:toChangeGameView];
      
            self.changePosition=NO;
        }
    }
    
}
-(void)createButtons
{
    for (int i=0; i<11; i++) {
        CGRect Rect1= CGRectMake(10+60*i,3*self.gameView.frame.size.height/4, 60, 20);
      //  CGRect Rect = CGRectMake(Rect1.origin.x, Rect1.origin.y+2, 20, 20);

        CALayer* rectangleToAdd = [CALayer layer];
        [rectangleToAdd setFrame:Rect1];
        [rectangleToAdd setBounds:Rect1];
        [rectangleToAdd setCornerRadius:5.0f];
        [rectangleToAdd setBackgroundColor:[[UIColor redColor]CGColor]];
        [rectangleToAdd setOpacity:1.0f];
   
       
        CGRect Rect=rectangleToAdd.frame;
        
        CATextLayer *label = [[CATextLayer alloc] init];
        [label setFont:@"Helvetica-Bold"];
        [label setFontSize:20];
        [label setFrame:Rect];
        if (i==10) {
             [label setString:[NSString stringWithFormat:@"%d+",10]];
        }
else
        [label setString:[NSString stringWithFormat:@"%d",i]];
        [label setAlignmentMode:kCAAlignmentCenter];
        [label setForegroundColor:[[UIColor blackColor] CGColor]];
        
        [rectangleToAdd addSublayer:label];
        
        [self.gameView.layer insertSublayer:rectangleToAdd atIndex:i];
        [self.gameView.layer setValue:rectangleToAdd forKeyPath:[NSString stringWithFormat:@"Number %d",i]];

    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint P=[(UITouch*)[touches anyObject] locationInView:self.gameView];
  
    for (CALayer* singleLayer in self.gameView.layer.sublayers)
    {
        
        if ([singleLayer containsPoint:[self.gameView.layer convertPoint:P toLayer:singleLayer]])
        {
        
                NSString* choosedAnswer=[[NSString alloc]init];
                choosedAnswer=[[singleLayer.sublayers firstObject]string];
                int answer=[choosedAnswer intValue];
            
            
            int resultInPercent = 100;
            if (self.goodAnswer != answer)
            {
                
                if (self.goodAnswer != 0 && answer!= 0)
                {
                    if (self.goodAnswer < answer)
                    {
                        resultInPercent = (int)(((float)self.goodAnswer / (float)answer) * 100.0f);
                    }
                    else
                    {
                        resultInPercent = (int)(((float)answer / (float)self.goodAnswer) * 100.0f);
                    }
                }
                
                else
                {
                    resultInPercent = 0;
                }
            }
            if (answer == 10 && self.goodAnswer >= 10)
                resultInPercent = 100;
            
                UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Result" message:[NSString stringWithFormat:@"You get %d %% correct. It was %d times",resultInPercent,self.goodAnswer] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
           
            
        }
    }
    
    
    
    
    
    
}
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self startPush:self];
}

-(void)create
{
    int bound;
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* textToDisplay=[[NSString alloc]init];
    
    for(int x=0;x<self.actuallSize;x++)
    {
        if (self.mode)
        {
            bound=10;
            lowBound=0;
            rndValue= lowBound + arc4random() % (bound - lowBound);
            numValue=[[NSNumber alloc]initWithInt:rndValue];
            
            self.toFind=[self.toFind stringByAppendingString:[NSString stringWithFormat:@"%d",[numValue intValue]]];
        }
        else
        {
            bound=26;
            lowBound=1;
            rndValue= lowBound + arc4random() % (bound - lowBound);
            numValue=[[NSNumber alloc]initWithInt:rndValue];
            
            self.toFind=[self.toFind stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
        }
    }
    
    textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
    
    if(self.theDataObject.useOtherVersion)
    {
        for (int x = 0; x < 41; x++)
        {
            if(x==0)
            {
                textToDisplay=[textToDisplay stringByAppendingString:@"   "];
            }
            if (self.mode)
            {
                if (arc4random_uniform(10) == 5 && x < 40 - self.actuallSize)
                {
                    textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
                    x += self.actuallSize;
                }
                bound=10;
                lowBound=0;
                rndValue= lowBound + arc4random() % (bound - lowBound);
                numValue=[[NSNumber alloc]initWithInt:rndValue];
                
                textToDisplay=[textToDisplay stringByAppendingString:[NSString stringWithFormat:@"%d",[numValue intValue]]];
            }
            else
            {
               if (arc4random_uniform(10)  == 5 && x < 40 - self.actuallSize)
                {
                    textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
                    x += self.actuallSize;

                }
                
                
                bound=26;
                lowBound=1;
                rndValue= lowBound + arc4random() % (bound - lowBound);
                numValue=[[NSNumber alloc]initWithInt:rndValue];
                
                textToDisplay=[textToDisplay stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
        }
           
        }
    }
    else
    {
    for (int i=0; i<10; i++)
    {
        for (int x = 0; x < i * 2; x++)
        {
                    if (self.mode)
                    {
                        
                        if (arc4random_uniform(10) == 5 && x < i * 2 - self.actuallSize)
                        {
                            textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
                            x += self.actuallSize;
                        }
                        bound=10;
                        lowBound=0;
                        rndValue= lowBound + arc4random() % (bound - lowBound);
                        numValue=[[NSNumber alloc]initWithInt:rndValue];
                        
                        textToDisplay=[textToDisplay stringByAppendingString:[NSString stringWithFormat:@"%d",[numValue intValue]]];
                        
                       
                    }
                    else
                    {
                        if (arc4random_uniform(10)  == 5 && x < i * 2 - self.actuallSize)
                        {
                            textToDisplay=[textToDisplay stringByAppendingString:self.toFind];
                            x += self.actuallSize;
                        }
                        
                        bound=26;
                        lowBound=1;
                        rndValue= lowBound + arc4random() % (bound - lowBound);
                        numValue=[[NSNumber alloc]initWithInt:rndValue];
                        
                        textToDisplay=[textToDisplay stringByAppendingString:[NSString stringWithFormat:@"%c",[numValue intValue]+96]];
                        
                    }
            }
        
          textToDisplay=[textToDisplay stringByAppendingString:@"\n"];
    }
    }
  
    self.textLabel.text=textToDisplay;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:self.toFind options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:textToDisplay options:0 range:NSMakeRange(0, [textToDisplay length])];
    NSLog(@"Found %i",numberOfMatches);
    
    self.goodAnswer=numberOfMatches-1;

self.textLabel.textAlignment=NSTextAlignmentCenter;
self.textLabel.text=textToDisplay;
[self.textLabel sizeToFit];
self.textLabel.center = CGPointMake(self.gameView.frame.size.width/2, self.positionY);

}

- (IBAction)sizeChange:(id)sender {
    self.actuallSize=(int)self.sizeSlider.value;
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
    self.sizeCounterLabel.text=[[[NSNumber alloc]initWithInt:self.sizeSlider.value]description];

    [self create];
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

- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
    [self create];
}

- (IBAction)startPush:(id)sender {
    self.textLabel.text=nil;
    [self.textLabel sizeToFit];
    self.toFind=[[NSString alloc]init];
    [self create];
}
@end
