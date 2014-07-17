//
//  RightViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "RightViewController.h"
#import "LessonData.h"
@interface RightViewController ()

@end

@implementation RightViewController

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
    [self refreshUI];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setLesson:(LessonData *)lesson
{
    if(_lesson!=lesson)
    {
        _lesson=lesson;
        [self refreshUI];
      
    }
}


-(void)refreshUI
{
    _header.text=_lesson.header;
    _userImage.image=[UIImage imageNamed:_lesson.userImage];
    _decription.text=_lesson.description;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectedLesson:(LessonData *)newLesson
{
    [self setLesson:newLesson];
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
