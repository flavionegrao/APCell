//
//  APCellDatePicker.m
//  MilkMap
//
//  Created by Flavio Negrão Torres on 6/9/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

#import "APCellDatePicker.h"

#import <APUtil/APUtil.h>


@interface APCellDatePicker ()

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, copy) void (^pickerDidChangeValue) (NSDate* date);

@end

@implementation APCellDatePicker

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCell];
    }
    return self;
}

- (void)awakeFromNib {
    
    // Initialization code
    [self configCell];
}

- (UIDatePicker*) datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectZero];
        [self addSubview:_datePicker];
        
        _datePicker.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary* viewsDict = @{@"view":_datePicker};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views: viewsDict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views: viewsDict]];
        
        _datePicker.date = self.selectedDate ?: [NSDate date];
    }
    return _datePicker;
}

- (void) configCell {
    _pickerMode = UIDatePickerModeDateAndTime;
    [self.datePicker addTarget:self action:@selector(pickerValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setSelectedDate:(NSDate *)selectedDate {
    _selectedDate = selectedDate;
    if (selectedDate) [self.datePicker setDate:selectedDate animated:YES];
}


- (void) setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    if (minimumDate) self.datePicker.minimumDate = minimumDate;
}


- (void) setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    if (maximumDate) self.datePicker.maximumDate = maximumDate;
}


- (void) setPickerMode:(UIDatePickerMode)pickerMode {
    self.datePicker.datePickerMode = pickerMode;
}



- (void) pickerValueDidChange: (UIDatePicker*) picker {
    NSDate* date;
    if (self.pickerMode == UIDatePickerModeDate) {
        
        // Usamos sempre hora,minuto e segunto atuais.
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
        date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[picker.date dateByIgnoringTime] options:0];
    } else {
        date = picker.date;
    }
    if (self.pickerDidChangeValue) self.pickerDidChangeValue(date);
}

@end
