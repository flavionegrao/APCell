//
//  APCellSwitch.m
//  APTableViewDS
//
//  Created by Flavio Negrão Torres on 6/9/14.
//  Copyright (c) 2014 Flavio Negrão Torres. All rights reserved.
//

#import "APCellSwitch.h"

@interface APCellSwitch()

@property (nonatomic, copy) void (^switchDidChangeValue) (BOOL value);

@end

@implementation APCellSwitch


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (style == UITableViewCellStyleDefault ||
        style == UITableViewCellStyleSubtitle) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            // Initialization code
            [self configView];
        }
        
    } else {
        NSLog(@"[APCellSwitch] - Only UITableViewCellStyleDefault or UITableViewCellStyleSubtitle are accepted for this kind of cell. Cell will be initialized with UITableViewCellStyleDefault in instead" );
        self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        if (self) {
            // Initialization code
            [self configView];
        }
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self configView];
}

- (void) configView {
//    self.accessoryType = UITableViewCellAccessoryNone;
//    self.detailTextLabel.text = nil;
    
    UISwitch* switchView = [[UISwitch alloc]initWithFrame:self.accessoryView.frame];
    switchView.on = self.switchState;
    [switchView addTarget:self action:@selector(switchValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = switchView;
}

- (void) setSwitchState:(BOOL)switchState {
    
    UISwitch* switchView = (UISwitch*) self.accessoryView;
    switchView.on = switchState;
    _switchState = switchState;
}

- (void) switchValueDidChange: (UISwitch*) switchView {
    if (self.switchDidChangeValue) {
        self.switchState = switchView.on;
        self.switchDidChangeValue(switchView.on);
    }
}

@end
