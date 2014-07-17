//
//  LeftViewTableViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/16/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "RootLessonTableViewController.h"
#import "LessonData.h"

@interface RootLessonTableViewController ()

@end

@implementation RootLessonTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
        _lessons = [NSMutableArray array];
        [_lessons addObject:[LessonData newLessonWithName:@"Intro" description:@"First view"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 1" description:@"First lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 2" description:@"Secound lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 3" description:@"Third lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 4" description:@"Fouth lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 5" description:@"Fifth lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 6" description:@"Sixth lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 7" description:@"Seventh lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 8" description:@"Eighth lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 9" description:@"Ninth lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 10" description:@"Tenth lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 11" description:@"Eleventh lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 12" description:@"Twelfth lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 13" description:@"Thirteenth lesson"]];
        [_lessons addObject:[LessonData newLessonWithName:@"Lesson 14" description:@"Fouthteenth lesson"]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [_lessons count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonData* lesson=_lessons[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text=lesson.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LessonData *selectedLesson=[_lessons objectAtIndex:indexPath.row];
    if(_delegate)
    {
        [_delegate selectedLesson:selectedLesson];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
