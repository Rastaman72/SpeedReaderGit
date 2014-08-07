//
//  TimerViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/6/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@end

@implementation TimerViewController

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
    self.timerViewTimerLabel.text=@"00:00.0";
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

- (IBAction)backPush:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    self.timerViewTimerLabel.text=[NSString stringWithFormat:@"%u:%02u.%u",mins,secs,fraction];
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
}
@end
