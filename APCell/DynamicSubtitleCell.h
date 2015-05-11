//
//  DynamicSubtitleCell.h
//  donaRaposa
//
//  Created by Flavio Negrão Torres on 28/01/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicSubtitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *subheadLabel;
@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

@end
