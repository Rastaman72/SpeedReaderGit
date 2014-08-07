//
//  MetronumViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/6/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MetronumViewController.h"

@interface MetronumViewController ()

@end

@implementation MetronumViewController

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
    self.metronumVIewTimeForMetronumCounter.text=[[[NSNumber alloc]initWithInt:self.metronumViewTimeForMetronumSlider.value]description];
    self.metronumViewTickCounter.text=[[[NSNumber alloc]initWithInt:self.metronumViewTickSlider.value]description];
    self.metronumViewSpeedReadCounter.text=[[[NSNumber alloc]initWithInt:self.metronumViewSpeedReadSlider.value]description];
    self.metronumViewTickPerWordCounter.text=[[[NSNumber alloc]initWithInt:self.metronumViewTickPerWordSlider.value]description];
    self.running=false;
    self.metronumViewTimerLabel.text=@"00:00.0";
    // Do any additional setup after loading the view.
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

- (IBAction)timerPush:(id)sender
{
    if (!self.running) {
        self.running=YES;
        self.startTime=[NSDate timeIntervalSinceReferenceDate];
        [sender setTitle:@"STOP" forState:UIControlStateNormal];
        [self updateTime];
    }
    else
    {
        [sender setTitle:@"START" forState:UIControlStateNormal];
        self.running=NO;
 
    }
}

-(void)updateTime
{
    if(!self.running) return;
    NSTimeInterval currentTime=[NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed =currentTime-self.startTime;
    
    int mins = (int)(elapsed /60);
    elapsed -= mins*60;
    
    int secs=(int)elapsed;
    elapsed -=secs;
    
    int fraction = elapsed*10.0;
    
    self.metronumViewTimerLabel.text=[NSString stringWithFormat:@"%u:%02u.%u",mins,secs,fraction];
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
}

- (IBAction)startPush:(id)sender {
}
- (IBAction)backPush:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)changeMode:(id)sender {
    
        if([self.metronumVIewChooseModeSlider isOn])
        {
            self.metronumViewTickLabel.enabled=NO;
            self.metronumViewTickSlider.enabled=NO;
            self.metronumViewTickCounter.enabled=NO;
            
            self.metronumViewTimeForMetronumLabel.enabled =NO;
            self.metronumViewTimeForMetronumSlider.enabled=NO;
            self.metronumVIewTimeForMetronumCounter.enabled=NO;
            
            self.metronumViewSpeedReadLabel.enabled=YES;
            self.metronumViewSpeedReadSlider.enabled=YES;
            self.metronumViewSpeedReadCounter.enabled=YES;
            
            self.metronumViewTickPerWordLabel.enabled=YES;
            self.metronumViewTickPerWordSlider.enabled=YES;
            self.metronumViewTickPerWordCounter.enabled=YES;
            
            self.metronumViewSetTimerLabel.enabled=NO;
             self.metronumViewSetSpeedLabel.enabled=YES;

        }
        else
        {
            self.metronumViewTickLabel.enabled=YES;
            self.metronumViewTickSlider.enabled=YES;
            self.metronumViewTickCounter.enabled=YES;
            
            self.metronumViewTimeForMetronumLabel.enabled =YES;
            self.metronumViewTimeForMetronumSlider.enabled=YES;
            self.metronumVIewTimeForMetronumCounter.enabled=YES;

            
            
            
            self.metronumViewSpeedReadLabel.enabled=NO;
            self.metronumViewSpeedReadSlider.enabled=NO;
            self.metronumViewSpeedReadCounter.enabled=NO;
            
            self.metronumViewTickPerWordLabel.enabled=NO;
            self.metronumViewTickPerWordSlider.enabled=NO;
            self.metronumViewTickPerWordCounter.enabled=NO;
            
            self.metronumViewSetTimerLabel.enabled=YES;
            self.metronumViewSetSpeedLabel.enabled=NO;

        }
    }

- (IBAction)timerForMetronumChange:(id)sender {
    self.metronumVIewTimeForMetronumCounter.text=[[[NSNumber alloc]initWithInt:self.metronumViewTimeForMetronumSlider.value]description];
}

- (IBAction)tickChange:(id)sender
{
     self.metronumViewTickCounter.text=[[[NSNumber alloc]initWithInt:self.metronumViewTickSlider.value]description];
}

-(IBAction)speedReadChange:(id)sender
{
    self.metronumViewSpeedReadCounter.text=[[[NSNumber alloc]initWithInt:self.metronumViewSpeedReadSlider.value]description];
}

-(void)tickPerWordChange:(id)sender
{
        self.metronumViewTickPerWordCounter.text=[[[NSNumber alloc]initWithInt:self.metronumViewTickPerWordSlider.value]description];
}
@end
