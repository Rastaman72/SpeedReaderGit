//
//  RootExercisesTableViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 7/17/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "RootExercisesTableViewController.h"
#import "ExercisesData.h"

@interface RootExercisesTableViewController ()

@end

@implementation RootExercisesTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
        _exercises = [NSMutableArray array];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Intro" description:@"First view"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 1" description:@"First Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 2" description:@"Secound Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 3" description:@"Third Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 4" description:@"Fouth Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 5" description:@"Fifth Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 6" description:@"Sixth Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 7" description:@"Seventh Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 8" description:@"Eighth Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 9" description:@"Ninth Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 10" description:@"Tenth Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 11" description:@"Eleventh Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 12" description:@"Twelfth Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 13" description:@"Thirteenth Exercises"]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 14" description:@"Fouthteenth Exercises"]];
        
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
     return [_exercises count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"Cell";
    ExercisesData* exercises=_exercises[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text=exercises.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExercisesData *selectedExcerses=[_exercises objectAtIndex:indexPath.row];
    if(_delegate)
    {
        [_delegate selectedExercises:selectedExcerses];
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
