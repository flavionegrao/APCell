//
//  APCellPesoPicker.h
//  MilkMap
//
//  Created by Flavio Negrão Torres on 6/30/14.
//  Copyright (c) 2014 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface APCellVolumePicker : UITableViewCell

@property (nonatomic, copy) void (^pickerDidChangeValueBlock) (NSNumber* volume);

@property (nonatomic, assign) NSInteger volumeMinimo;
@property (nonatomic, assign) NSInteger volumeMaximo;
@property (nonatomic, assign) NSInteger selectedVolume;

- (void) setSubtitle:(NSString *)subtitle;

@end
