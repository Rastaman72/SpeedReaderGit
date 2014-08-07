//
//  SettingsViewController.m
//  SpeedReader
//
//  Created by LGBS dev on 8/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.fontPicker.delegate=self;
    self.fontPicker.dataSource=self;
    self.fontArray=[[NSMutableArray alloc]init];
    [self.fontArray addObjectsFromArray:[UIFont familyNames]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.settingsViewInterfaceCounter.text=[[[NSNumber alloc]initWithFloat:self.settingsViewInterfaceSlider.value]description];
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

- (IBAction)interfaceChange:(id)sender
{
     self.settingsViewInterfaceCounter.text=[[[NSNumber alloc]initWithFloat:self.settingsViewInterfaceSlider.value]description];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.fontArray count];

}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.fontArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.theDataObject=[self theAppDataObject];
    
        
}
- (SharedData*) theAppDataObject;
{
	id<AppDelegateDataShared> theDelegate = (id<AppDelegateDataShared>) [UIApplication sharedApplication].delegate;
	SharedData* theDataObject;
	theDataObject = (SharedData*) theDelegate.theAppDataObject;
	return theDataObject;
}
@end
