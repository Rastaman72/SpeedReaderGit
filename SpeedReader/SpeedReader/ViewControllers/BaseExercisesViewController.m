//
//  BaseExercisesViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "BaseExercisesViewController.h"

@interface BaseExercisesViewController ()

@end

@implementation BaseExercisesViewController

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
    // Do any additional setup after loading the view.
}
/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)startExercises:(UISlider *)exercisesSlider
{
    if (self.scrollingTimer == nil)
    {
        self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:(exercisesSlider.value/1000)
                                                               target:self selector:@selector(autoscrollTimerFired) userInfo:nil repeats:YES];
    }
    else
    {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
        
    }

}

-(UITextView*)exercisesAnimation:(UITextView*)exercisesText number:(int)excNumber
{
    NSLog(@"%f",exercisesText.contentSize.height);
    if(self.position >=exercisesText.contentSize.height)
    {
        [self.scrollingTimer invalidate];
        self.scrollingTimer = nil;
        return;
    }
    NSLog(@"%f",exercisesText.contentSize.height);
    
    if (self.position>=self.maxPosition-exercisesText.font.lineHeight && self.maxPosition<self.exercisesOneText.contentSize.height )
    {
        [exercisesText setContentOffset:CGPointMake(0, self.maxPosition) animated:YES];
        self.maxPosition+=self.actuallOffset;
        return exercisesText;
    }
    else
    {
        [self createFrame:excNumber];
        
        if (self.position==0) {
            [[[exercisesText]layer]insertSublayer:self.readFrame atIndex:0];
            
        }
        
        
        [[[exercisesText]layer]replaceSublayer:[exercisesText.layer.sublayers objectAtIndex:0] with:self.readFrame];
        
        self.position+=exercisesText.font.lineHeight*2;
        return exercisesText;
    }
    for (id test in self.exercisesOneText.layer.sublayers) {
        NSLog(@"%@",test);
    }
    
}

-(void)createFrame:(int)excNumber
{
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

*/
@end
