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

    self.actuallSize=3;
    self.step=2;
    [self create];
    // Do any additional setup after loading the view.
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
    self.textLabel.center = CGPointMake(self.view.frame.size.width/2, 300);
    
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
