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
    self.actuallSize=1;
    self.step=2;
    [self create];
    // Do any additional setup after loading the view.
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
    self.textLabel.center = CGPointMake(self.view.frame.size.width/2, 300);
    
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
