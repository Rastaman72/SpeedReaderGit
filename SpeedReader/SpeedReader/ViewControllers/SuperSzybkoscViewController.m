//
//  SuperSzybkoscViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 9/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SuperSzybkoscViewController.h"

@interface SuperSzybkoscViewController ()

@end

@implementation SuperSzybkoscViewController

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
    self.speedReadCounter.text=[[[NSNumber alloc]initWithInt:self.speedReadSlider.value]description];
    self.tickPerWordCounterLabel.text=[[[NSNumber alloc]initWithInt:self.tickPerWordSlider.value]description];
    self.running=false;
    self.timerLabel.text=@"00:00.0";
    [self.timerLabel sizeToFit];
    self.metronom = [self createSoundID: @"metronom.wav"];
    self.soundCounter=1;
    

    // Do any additional setup after loading the view.
}

- (IBAction)startPush:(id)sender
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
    
    if (self.audioPlayingTimer == nil) {
        NSTimeInterval timer=60/(self.speedReadSlider.value/self.tickPerWordSlider.value);
        self.audioPlayingTimer = [NSTimer scheduledTimerWithTimeInterval:(timer)
                                                                  target:self selector:@selector(playSound) userInfo:nil repeats:YES];
    }
    
    else {
        [self.audioPlayingTimer invalidate];
        self.audioPlayingTimer = nil;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playSound
{
        AudioServicesPlaySystemSound(self.metronom);
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)speedChange:(id)sender {
    self.speedReadCounter.text=[[[NSNumber alloc]initWithInt:self.speedReadSlider.value]description];
    
    [self.audioPlayingTimer invalidate];
    self.audioPlayingTimer = nil;
    
    if (self.audioPlayingTimer == nil) {
        
        NSTimeInterval timer=60/(self.speedReadSlider.value/self.tickPerWordSlider.value);
        self.audioPlayingTimer = [NSTimer scheduledTimerWithTimeInterval:(timer)
                                                                  target:self selector:@selector(playSound) userInfo:nil repeats:YES];
    }

}
- (IBAction)tickPerWordChange:(id)sender {
    self.tickPerWordCounterLabel.text=[[[NSNumber alloc]initWithInt:self.tickPerWordSlider.value]description];
    [self.audioPlayingTimer invalidate];
    self.audioPlayingTimer = nil;
    
    if (self.audioPlayingTimer == nil) {
        
        NSTimeInterval timer=60/(self.speedReadSlider.value/self.tickPerWordSlider.value);
        self.audioPlayingTimer = [NSTimer scheduledTimerWithTimeInterval:(timer)
                                                                  target:self selector:@selector(playSound) userInfo:nil repeats:YES];
    }
}

@end
