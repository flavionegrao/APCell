//
//  APCellPesoPicker.m
//  MilkMap
//
//  Created by Flavio Negrão Torres on 6/30/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

#import "APCellVolumePicker.h"

@interface APCellVolumePicker() <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) UIPickerView* picker;

@end


@implementation APCellVolumePicker

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCell];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self configCell];
}

- (void) configCell {
    
    // Picker
    self.picker = [[UIPickerView alloc]initWithFrame:self.bounds];
    self.picker.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.picker];
    NSDictionary* viewsDict = @{@"view":self.picker};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views: viewsDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views: viewsDict]];
    
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    // Defaults
    self.volumeMinimo = 0;
    self.volumeMaximo = 1000;
}


- (void) setSelectedVolume:(NSInteger)selectedVolume {
    _selectedVolume = selectedVolume;
    if(selectedVolume <= self.volumeMinimo) {
        selectedVolume = self.volumeMinimo;
    } else if(selectedVolume >= self.volumeMaximo){
         selectedVolume = self.volumeMaximo;
    }
    
    [self.picker selectRow:selectedVolume - self.volumeMinimo inComponent:0 animated:NO];
}


- (void) setSubtitle:(NSString *)subtitle {
    
    if (subtitle) {
        
        UILabel* subtitleLabel = [UILabel new];
        subtitleLabel.text = subtitle;
        [subtitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.picker addSubview:subtitleLabel];
       [self.picker addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[subtitleLabel]-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"subtitleLabel":subtitleLabel}]];
        
        
        [self.picker addConstraint:[NSLayoutConstraint constraintWithItem:subtitleLabel
                                                                          attribute:NSLayoutAttributeCenterY
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.picker
                                                                          attribute:NSLayoutAttributeCenterY
                                                                         multiplier:1
                                                                           constant:0]];
    }
}


#pragma mark - UIPickerView DataSource

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.volumeMaximo - self.volumeMinimo + 1;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


#pragma mark - UIPickerView Delegate

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%ld",(long) row + self.volumeMinimo];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(self.pickerDidChangeValueBlock) self.pickerDidChangeValueBlock(@(row + self.volumeMinimo));
}

@end
