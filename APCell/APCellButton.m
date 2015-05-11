//
//  APCellButton.m
//  MilkMap
//
//  Created by Flavio Negrão Torres on 2/27/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

#import "APCellButton.h"

@interface APCellButton ()

@property (nonatomic, copy) void (^buttonDidTouchBlock) (void);
@property (strong, nonatomic) UIButton* button;

@end


@implementation APCellButton

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _buttonTitle = @"No Title Set";
        _buttonTitleTextColor = self.tintColor;
        [self configCell];
    }
    return self;
}

- (void)awakeFromNib {
    
     [super awakeFromNib];
    // Initialization code
    [self configCell];
}

- (void) setButtonTitle:(NSString *)buttonTitle {
     [self.button setTitle:buttonTitle forState:UIControlStateNormal];
    _buttonTitle = buttonTitle;
}

- (void) setButtonTitleTextColor:(UIColor *)buttonTitleTextColor {
    [self.button setTitleColor:buttonTitleTextColor forState:UIControlStateNormal];
    _buttonTitleTextColor = buttonTitleTextColor;
}

- (void) setButtonEnabled:(BOOL)buttonEnabled {
    self.button.enabled = buttonEnabled;
    
}


- (void) configCell {
    
    self.button = [[UIButton alloc]initWithFrame:CGRectZero];
    self.button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.button setTitle:self.buttonTitle forState:UIControlStateNormal];
    [self.button setTitleColor:self.buttonTitleTextColor forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [self.button setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.contentView addSubview:self.button];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[button]|" options:0 metrics:nil views:@{@"button":self.button}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|" options:0 metrics:nil views:@{@"button":self.button}]];
    
    [self.button addTarget:self action:@selector(buttonDidTouch:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) buttonDidTouch: (UIButton*) sender {
    if (self.buttonDidTouchBlock) self.buttonDidTouchBlock();
}


@end
