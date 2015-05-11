//
//  APCellSwitch.h
//  APTableViewDS
//
//  Created by Flavio Negrão Torres on 6/9/14.
//  Copyright (c) 2014 Flavio Negrão Torres. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APCellSwitch : UITableViewCell

@property (nonatomic, assign) BOOL switchState;

- (void) setSwitchDidChangeValue:(void (^) (BOOL value)) block;

@end
