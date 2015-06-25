//
//  DynamicSubtitleCell.m
//  donaRaposa
//
//  Created by Flavio Negrão Torres on 28/01/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

#import "DynamicSubtitleCell.h"

@interface DynamicSubtitleCell()
@property (nonatomic, strong) NSLayoutConstraint* heightConstraint;
@end

@implementation DynamicSubtitleCell


- (NSLayoutConstraint*) heightConstraint {
    if (!_heightConstraint) {
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.minimumHeight];
    }
    return _heightConstraint;
}



- (void) setMinimumHeight:(CGFloat) minimumHeight {
    _minimumHeight = minimumHeight;
    [self.contentView addConstraint:self.heightConstraint];
    [self setNeedsUpdateConstraints];
}


- (void) updateConstraints {
    self.heightConstraint.constant = self.minimumHeight;
    [super updateConstraints];
}

@end
