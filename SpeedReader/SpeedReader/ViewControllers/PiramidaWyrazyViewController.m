//
//  PiramidaWyrazyViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "PiramidaWyrazyViewController.h"

@interface PiramidaWyrazyViewController ()

@end

@implementation PiramidaWyrazyViewController

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
    self.xmlManager = [self theAppDataObject];
    self.positionY=300;
    self.actuallSize=3;
    self.step=2;
    [self create];
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
            
            CGRect toChangeTextLabel= self.textLabel.frame;
            toChangeTextLabel.origin.y-=90;
            [self.textLabel setFrame:toChangeTextLabel];
            
            
            
            CGRect toChangeGetNewWordButton= self.getNewWordButton.frame;
            toChangeGetNewWordButton.origin.y-=225;
            [self.getNewWordButton setFrame:toChangeGetNewWordButton];
            
            self.positionY-=90;
            
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
           
            
            CGRect toChangeTextLabel= self.textLabel.frame;
            toChangeTextLabel.origin.y+=90;
            [self.textLabel setFrame:toChangeTextLabel];
            
            
            
            CGRect toChangeGetNewWordButton= self.getNewWordButton.frame;
            toChangeGetNewWordButton.origin.y+=225;
            [self.getNewWordButton setFrame:toChangeGetNewWordButton];
            self.positionY+=90;
            
            self.changePosition=NO;
        }
    }
    
}
-(void)create
{
    NSString* textToDisplay=[[NSString alloc]init];
       
    for (int i=0; i<11; i++) {
        
            textToDisplay=[textToDisplay stringByAppendingString:[self.xmlManager getWord:self.actuallSize]];
        
        textToDisplay=[textToDisplay stringByAppendingString:@"\n"];
        
        
        self.actuallSize+=self.step;
    }
    
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    self.textLabel.text=textToDisplay;
    [self.textLabel sizeToFit];
    self.textLabel.center = CGPointMake(self.view.frame.size.width/2, self.positionY);
    
}

- (IBAction)getNewWords:(id)sender {
    self.textLabel.text=nil;
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    [self.textLabel sizeToFit];
    self.actuallSize=3;
    [self create];
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
