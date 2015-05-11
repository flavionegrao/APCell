//
//  APCellDatePicker.h
//  MilkMap
//
//  Created by Flavio Negrão Torres on 6/9/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Use:
 - (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 return 217;
 }
 */
@interface APCellDatePicker : UITableViewCell

@property (nonatomic, strong) NSDate* selectedDate;

//default is UIDatePickerModeDateAndTime
@property (nonatomic, assign) UIDatePickerMode pickerMode;

@property (nonatomic, assign) NSDate* minimumDate;
@property (nonatomic, assign) NSDate* maximumDate;

- (void) setPickerDidChangeValue:(void (^) (NSDate* date)) block;

@end
