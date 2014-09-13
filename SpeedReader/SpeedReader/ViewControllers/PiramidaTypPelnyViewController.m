//
//  PiramidaTypPelnyViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "PiramidaTypPelnyViewController.h"

@interface PiramidaTypPelnyViewController ()

@end

@implementation PiramidaTypPelnyViewController

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
    self.mode=YES;
    self.positionY=300;
    self.actuallSize=1;
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
            toChangeTextLabel.origin.y-=100;
            [self.textLabel setFrame:toChangeTextLabel];
            
            
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y-=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            CGRect toChangetGenerateObjectsButton= self.generateObjectsButton.frame;
            toChangetGenerateObjectsButton.origin.y-=225;
            [self.generateObjectsButton setFrame:toChangetGenerateObjectsButton];
            
            self.positionY-=90;
            self.changePosition=YES;
        }
    }
    
    else if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown)
    {
        if(self.changePosition)
        {
            
          
            CGRect toChangeTextLabel= self.textLabel.frame;
            toChangeTextLabel.origin.y+=100;
            [self.textLabel setFrame:toChangeTextLabel];
            
            
            
            CGRect toChangeSetModeView= self.setModeView.frame;
            toChangeSetModeView.origin.y+=225;
            [self.setModeView setFrame:toChangeSetModeView];
            
            CGRect toChangetGenerateObjectsButton= self.generateObjectsButton.frame;
            toChangetGenerateObjectsButton.origin.y+=225;
            [self.generateObjectsButton setFrame:toChangetGenerateObjectsButton];
            
           self.positionY+=90;
            self.changePosition=NO;
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)create
{
    int bound;
    int lowBound = 0;
    int rndValue;
    NSNumber* numValue;
    NSString* textToDisplay=[[NSString alloc]init];
    NSString* letters=[[NSString alloc]init];
    
    for (int i=0; i<11; i++) {
        for (int j=0; j<self.actuallSize; j++) {
            
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
        textToDisplay=[textToDisplay stringByAppendingString:@"\n"];
       

        self.actuallSize+=self.step;
        }
    
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    self.textLabel.text=textToDisplay;
    [self.textLabel sizeToFit];
    self.textLabel.center = CGPointMake(self.view.frame.size.width/2, self.positionY);
    
}

- (IBAction)modeChange:(id)sender {
    self.mode=!self.mode;
    self.textLabel.text=nil;
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    [self.textLabel sizeToFit];
    self.actuallSize=1;
    [self create];
    
}
- (IBAction)getNewLetters:(id)sender {
    self.textLabel.text=nil;
    self.textLabel.textAlignment=NSTextAlignmentCenter;
    [self.textLabel sizeToFit];
    self.actuallSize=1;    
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

@end
