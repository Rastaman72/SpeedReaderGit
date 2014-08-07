//
//  SettingsViewController.h
//  SpeedReader
//
//  Created by LGBS dev on 8/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "AppDelegateDataShared.h"
@interface SettingsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *settingsViewInterfaceLabel;
@property (weak, nonatomic) IBOutlet UISlider *settingsViewInterfaceSlider;
- (IBAction)interfaceChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *settingsViewInterfaceCounter;

@property (weak, nonatomic) IBOutlet UIPickerView *fontPicker;

@property(nonatomic,strong)NSMutableArray* fontArray;
@property(nonatomic,strong)SharedData* theDataObject;
@end
