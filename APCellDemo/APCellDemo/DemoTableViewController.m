//
//  DemoTableViewController.m
//  APCellDemo
//
//  Created by Flavio Negrão Torres on 20/06/15.
//  Copyright (c) 2015 Apetis. All rights reserved.
//

#import "DemoTableViewController.h"

typedef NS_ENUM(NSInteger, TableRow) {
    TableRowDefault,
    TableRowTextFieldPercentage,
    TableRowTextFieldFreeText,
    TableRowTextFieldFreeText2,
};

@implementation DemoTableViewController

- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell*) tableView:(nonnull UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.item) {
        case TableRowDefault: {
            UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = @"UITableViewCellStyleDefault";
            return cell;
        }
        case TableRowTextFieldPercentage: {
            APCellTextField* cell = [[APCellTextField alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            //cell.textInsetFromLeftMargin = 130;
            cell.prefixText = @"Desconto";
            cell.sufixText = @" %";
            cell.placeHolderText = @"TableRowTextFieldPercentage";
            cell.textfieldInputType = APStringInputTypeNumberDecimal;
            cell.maxDecimalPlaces = 2;
            cell.textAlignment = NSTextAlignmentRight;
            cell.returnKeyType = UIReturnKeyNext;
            [cell setCellDidClickReturn:^{
                NSIndexPath* otherIndexPath = [NSIndexPath indexPathForItem:TableRowTextFieldFreeText inSection:0];
                UITableViewCell* otherCell = [tableView cellForRowAtIndexPath:otherIndexPath];
                [otherCell becomeFirstResponder];
            }];
            return cell;
        }
            
        case TableRowTextFieldFreeText: {
            APCellTextField* cell = [[APCellTextField alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.prefixText = @"Prefixo";
            cell.prefixTextMiniumWidth = 120;
            cell.placeHolderText = @"TableRowTextFieldFreeText";
            cell.textfieldInputType = APStringInputTypeFreeText;
            cell.textAlignment = NSTextAlignmentLeft;
            cell.returnKeyType = UIReturnKeyDone;
            [cell setCellDidClickReturn:^{
                [tableView endEditing:YES];
            }];
            return cell;
        }
            
        case TableRowTextFieldFreeText2: {
            APCellTextField* cell = [[APCellTextField alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.prefixText = @"Prexixo Maior";
            cell.prefixTextMiniumWidth = 120;
            cell.placeHolderText = @"TableRowTextFieldFreeText";
            cell.textfieldInputType = APStringInputTypeFreeText;
            cell.textAlignment = NSTextAlignmentLeft;
            cell.returnKeyType = UIReturnKeyDone;
            [cell setCellDidClickReturn:^{
                [tableView endEditing:YES];
            }];
            return cell;
        }
        default: return nil;
    }
}

@end
