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
@property (nonatomic, copy) UIColor* buttonTitleTextColor;
@property (nonatomic, assign, getter=isButtonEnabled) BOOL buttonEnabled;

- (void) setButtonDidTouchBlock:(void(^) (void)) block;

@end
