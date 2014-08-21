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
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Intro" description:@"First view" number:0]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 1" description:@"First Exercises" number:1]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 2" description:@"Secound Exercises" number:2]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 3" description:@"Third Exercises" number:3]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 4" description:@"Fouth Exercises"number:4]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 5" description:@"Fifth Exercises" number:5]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 6" description:@"Sixth Exercises" number:6]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 7" description:@"Seventh Exercises" number:7]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 8" description:@"Eighth Exercises" number:8]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 9" description:@"Ninth Exercises" number:9]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 10" description:@"Tenth Exercises" number:10]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 11" description:@"Eleventh Exercises" number:11]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 12" description:@"Twelfth Exercises" number:12]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 13" description:@"Thirteenth Exercises" number:13]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 14" description:@"Fouthteenth Exercises" number:14]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 15" description:@"Fouthteenth Exercises" number:15]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 16" description:@"Fouthteenth Exercises" number:16]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 17" description:@"Fouthteenth Exercises" number:17]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 18" description:@"Fouthteenth Exercises" number:18]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 19" description:@"Fouthteenth Exercises" number:19]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 20" description:@"Fouthteenth Exercises" number:20]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 21" description:@"Fouthteenth Exercises" number:21]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 22" description:@"Fouthteenth Exercises" number:22]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 23" description:@"Fouthteenth Exercises" number:23]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 24" description:@"Fouthteenth Exercises" number:24]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 25" description:@"Fouthteenth Exercises" number:25]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 26" description:@"Fouthteenth Exercises" number:26]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 27" description:@"Fouthteenth Exercises" number:27]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 28" description:@"Fouthteenth Exercises" number:28]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 29" description:@"Thirteenth Exercises" number:29]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 30" description:@"Fouthteenth Exercises" number:30]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 31" description:@"Fouthteenth Exercises" number:31]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 32" description:@"Fouthteenth Exercises" number:32]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 33" description:@"Fouthteenth Exercises" number:33]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 34" description:@"Fouthteenth Exercises" number:34]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 35" description:@"Fouthteenth Exercises" number:35]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 36" description:@"Fouthteenth Exercises" number:36]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 37" description:@"Fouthteenth Exercises" number:37]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 38" description:@"Fouthteenth Exercises" number:38]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 39" description:@"Fouthteenth Exercises" number:39]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 40" description:@"Fouthteenth Exercises" number:40]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 41" description:@"Fouthteenth Exercises" number:41]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 42" description:@"Fouthteenth Exercises" number:42]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 43" description:@"Fouthteenth Exercises" number:43]];
        [_exercises addObject:[ExercisesData newExercisesWithName:@"Exercises 44" description:@"Fouthteenth Exercises" number:44]];
        
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
    self.theDataObject = [self theAppDataObject];
    self.theDataObject.selectPart=selectedExcerses;
        if(_delegate)
    {
        [_delegate selectedExercises:selectedExcerses];
    }
}

- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
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
