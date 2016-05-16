//
//  ViewController.m
//  earthdate
//
//  Created by myComputer on 4/24/16.
//  Copyright © 2016 presentPhase. All rights reserved.
//

#import "ViewController.h"
#import "TransientContainer.h"

@interface ViewController () {
    __weak IBOutlet UIDatePicker *earthdatePicker;
    __weak IBOutlet UITextView *textView;
    
    NSMutableDictionary *appData;
}

@end

@implementation ViewController

#pragma mark - PickerDelegates

- (IBAction)earthdatePicker:(UIDatePicker *)sender {
    
}

// When the copy button is pressed
- (IBAction)copyEarthdate:(UIButton *)sender {
    NSDate *eDate = earthdatePicker.date;
    NSCalendar *calendar = earthdatePicker.calendar;
    
    int year= (int)[calendar component:NSCalendarUnitYear fromDate:eDate];
    int mon = (int)[calendar component:NSCalendarUnitMonth fromDate:eDate];
    int day = (int)[calendar component:NSCalendarUnitDay fromDate:eDate];

    int earthDate = [self calculateEarthDay:day fromMonth:mon andYear:year];
    NSString *earthdateString = [NSString stringWithFormat:@"#earthdate %i.%i", year, earthDate];
    
    textView.text = earthdateString;
    
    // Decide what data needs to be saved
    [self updateData];
    
    // Actually save
    [self saveData];
}

#pragma mark - Helpers

// A calculation method
- (int)calculateEarthDay:(int)day fromMonth:(int)month andYear:(int)year {
    int earthDate = day;

    while (month-->1) {
        switch (month) {
            case 1: // Jan
                earthDate += 31;
                break;
            case 2: // Feb
                earthDate += year%4==0 ? 29 : 28;
                break;
            case 3: // Mar
                earthDate += 31;
                break;
            case 4: // Apr
                earthDate += 30;
                break;
            case 5: // May
                earthDate += 31;
                break;
            case 6: // June
                earthDate += 30;
                break;
            case 7: // July
                earthDate += 31;
                break;
            case 8: // Aug
                earthDate += 31;
                break;
            case 9: // Sep
                earthDate += 30;
                break;
            case 10:// Oct
                earthDate += 31;
                break;
            case 11:// Nov
                earthDate += 30;
                break;
                // Dec is not possible
            default:
                break;
        }
    }
    
    return earthDate;
}

#pragma mark - Data Handling

- (void)updateData {
    // TODO: perform necessary things to update the appData
    // appData <-- do stuff to it
}

- (void)saveData {
    [[TransientContainer sharedInstance] setContentForKey:@"data" data:appData];
    [[TransientContainer sharedInstance] saveToDisk];
}

- (void)loadData {
    // Load whatever on disk into "saveData"
    NSDictionary *saveData = [[TransientContainer sharedInstance] getContentForKey:@"data"];
    
    // Super fancy if-check: if saveData exists, then set appData to it, else create a new one.
    appData = saveData ? saveData : @{}.mutableCopy;
}

#pragma mark - Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
