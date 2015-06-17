//
//  APCellButton.m
//  MilkMap
//
//  Created by Flavio Negrão Torres on 2/27/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

#import "APCellButton.h"
#import "UIColor+APUtil.h"

@interface APCellButton ()

@property (nonatomic, copy) void (^buttonDidTouchBlock) (void);
@property (strong, nonatomic) UIButton* button;

@end


@implementation APCellButton

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    _buttonTitleTextColor = buttonTitleTextColor;
    [self.button setTitleColor:buttonTitleTextColor forState:UIControlStateNormal];
    [self.button setTitleColor:[buttonTitleTextColor blendWithColor:[UIColor whiteColor] alpha:0.75] forState:UIControlStateHighlighted];
}

- (void) setButtonTitleTextAlignment:(NSTextAlignment)buttonTitleTextAlignment {
    _buttonTitleTextAlignment = buttonTitleTextAlignment;
    self.button.titleLabel.textAlignment = buttonTitleTextAlignment;
}

- (void) setButtonEnabled:(BOOL)buttonEnabled {
    self.button.enabled = buttonEnabled;
}


- (void) configCell {
    
    _buttonTitle = @"No Title Set";
    _buttonTitleTextColor = self.tintColor;
    _buttonFontSize = 14;
    _buttonTitleTextAlignment = NSTextAlignmentLeft;
    
    
    _button = [[UIButton alloc]initWithFrame:CGRectZero];
    _button.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_button setTitle:_buttonTitle forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:_buttonFontSize];
    _button.titleLabel.textAlignment = _buttonTitleTextAlignment;
    
    [_button setTitleColor:_buttonTitleTextColor forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_button setTitleColor:[_buttonTitleTextColor blendWithColor:[UIColor whiteColor] alpha:0.75] forState:UIControlStateHighlighted];
    
    [_button setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.contentView addSubview:_button];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(18)-[button]" options:0 metrics:nil views:@{@"button":_button}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|" options:0 metrics:nil views:@{@"button":_button}]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    
    [_button addTarget:self action:@selector(buttonDidTouch:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) buttonDidTouch: (UIButton*) sender {
    if (self.buttonDidTouchBlock) self.buttonDidTouchBlock();
}

- (void) setButtonFontSize:(NSInteger)buttonFontSize {
    _buttonFontSize = buttonFontSize;
    self.button.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
}


@end
