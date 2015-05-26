//
//  APCellButton.h
//  MilkMap
//
//  Created by Flavio Negrão Torres on 2/27/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APCellButton : UITableViewCell

@property (nonatomic, copy) NSString* buttonTitle;

/// Default is tintColor
@property (nonatomic, copy) UIColor* buttonTitleTextColor;

/// Default is 14
@property (nonatomic, assign) NSInteger buttonFontSize;

@property (nonatomic, assign, getter=isButtonEnabled) BOOL buttonEnabled;

- (void) setButtonDidTouchBlock:(void(^) (void)) block;

@end
