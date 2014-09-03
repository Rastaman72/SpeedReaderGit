//
//  MetronumEXCViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MetronumEXCViewController.h"

@interface MetronumEXCViewController ()

@end

@implementation MetronumEXCViewController

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
    self.timeForMetronumCounterLabel.text=[[[NSNumber alloc]initWithInt:self.timeForMetronumSlider.value]description];
    self.tickCounterLabel.text=[[[NSNumber alloc]initWithInt:self.tickSlider.value]description];
    self.speedReadCounter.text=[[[NSNumber alloc]initWithInt:self.speedReadSlider.value]description];
    self.tickPerWordCounterLabel.text=[[[NSNumber alloc]initWithInt:self.tickPerWordSlider.value]description];
    self.running=false;
    self.timerLabel.text=@"00:00.0";
    [self.timerLabel sizeToFit];
    self.metronom = [self createSoundID: @"metronom.wav"];
       self.metronom2 = [self createSoundID: @"metronom2.wav"];
    self.soundCounter=0;

    // Do any additional setup after loading the view.
}
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
    
    self.timerLabel.text=[NSString stringWithFormat:@"%u:%02u.%u",mins,secs,fraction];
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
}
- (IBAction)startPush:(id)sender {
    if (self.audioPlayingTimer == nil) {
        if(self.setTimerLabel.enabled==YES)
        {
        self.audioPlayingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.timeForMetronumSlider.value/1000)
                                                               target:self selector:@selector(playSound) userInfo:nil repeats:YES];
        }
        else
        {
            self.audioPlayingTimer = [NSTimer scheduledTimerWithTimeInterval:(self.timeForMetronumSlider.value/1000)
                                                                      target:self selector:@selector(playSound) userInfo:nil repeats:YES];
        }
            
    } else {
        [self.audioPlayingTimer invalidate];
        self.audioPlayingTimer = nil;
    }

}

-(void)playSound
{
    if(self.setTimerLabel.enabled==YES)
    {
    if(self.soundCounter<self.tickSlider.value)
    AudioServicesPlaySystemSound(self.metronom);
    else{
        AudioServicesPlaySystemSound(self.metronom2);
        self.soundCounter=0;
    }
    }
    else{
        if(self.soundCounter<self.tickPerWordSlider.value)
            AudioServicesPlaySystemSound(self.metronom);
        else{
            AudioServicesPlaySystemSound(self.metronom);
            self.soundCounter=0;
        }

    }
}

-(SystemSoundID) createSoundID: (NSString*)name
{
    NSString *path = [NSString stringWithFormat: @"%@/%@",
                      [[NSBundle mainBundle] resourcePath], name];
    
    
    NSURL* filePath = [NSURL fileURLWithPath: path isDirectory: NO];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    return soundID;
}


- (IBAction)changeMode:(id)sender {
    
    if([self.chooseModeSlider isOn])
    {
        self.tickLabel.enabled=NO;
        self.tickSlider.enabled=NO;
        self.tickCounterLabel.enabled=NO;
        
        self.timeForMetronumLabel.enabled =NO;
        self.timeForMetronumSlider.enabled=NO;
        self.timeForMetronumCounterLabel.enabled=NO;
        
        self.speedReadLabel.enabled=YES;
        self.speedReadSlider.enabled=YES;
        self.speedReadCounter.enabled=YES;
        
        self.tickPerWordLabel.enabled=YES;
        self.tickPerWordSlider.enabled=YES;
        self.tickPerWordCounterLabel.enabled=YES;
        
        self.setTimerLabel.enabled=NO;
        self.setSpeedLabel.enabled=YES;
        
    }
    else
    {
        self.tickLabel.enabled=YES;
        self.tickSlider.enabled=YES;
        self.tickCounterLabel.enabled=YES;
        
        self.timeForMetronumLabel.enabled =YES;
        self.timeForMetronumSlider.enabled=YES;
        self.timeForMetronumCounterLabel.enabled=YES;
        
        
        
        
        self.speedReadLabel.enabled=NO;
        self.speedReadSlider.enabled=NO;
        self.speedReadCounter.enabled=NO;
        
        self.tickPerWordLabel.enabled=NO;
        self.tickPerWordSlider.enabled=NO;
        self.tickPerWordCounterLabel.enabled=NO;
        
        self.setTimerLabel.enabled=YES;
        self.setSpeedLabel.enabled=NO;
        
    }
}

- (IBAction)timerForMetronumChange:(id)sender {
    self.timeForMetronumCounterLabel.text=[[[NSNumber alloc]initWithInt:self.timeForMetronumSlider.value]description];
}

- (IBAction)tickChange:(id)sender
{
    self.tickCounterLabel.text=[[[NSNumber alloc]initWithInt:self.tickSlider.value]description];
}

-(IBAction)speedReadChange:(id)sender
{
    self.speedReadCounter.text=[[[NSNumber alloc]initWithInt:self.speedReadSlider.value]description];
}

-(void)tickPerWordChange:(id)sender
{
    self.tickPerWordCounterLabel.text=[[[NSNumber alloc]initWithInt:self.tickPerWordSlider.value]description];
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
