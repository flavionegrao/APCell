//
//  APTextFieldTableViewCell.m
//  MilkMap
//
//  Created by Flavio Torres on 07/08/13.
//  Copyright (c) 2013 Apetis. All rights reserved.
//

#import "APCellTextField.h"

#import "NSNumber+APUtil.h"
#import "NSString+APUtil.h"


static NSInteger const kAPTextFieldHorizontalInset = 20;


@interface APCellTextField () <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,copy) void (^cellDidEdit) (NSString* text);
@property (nonatomic,copy) void (^didBecomeFirstResponder)(void);
@property (nonatomic,copy) void (^cellDidClickReturn) (void);

@property (nonatomic,strong) UITextField* textField;
@property (nonatomic,strong) NSArray* textFielHorizontalContraints;
@property (nonatomic,strong) NSString* decimalSeparator;

@end

@implementation APCellTextField

// via tableview:dequeuecell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCell];
    }
    return self;
}


// Via static cell
- (void) awakeFromNib {
    [self configCell];
}

//- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    
//    self.shouldIndentWhileEditing = NO;
//    if (!editing) {
//        self.textField.textAlignment = NSTextAlignmentRight;
//    } else {
//        self.textField.textAlignment = NSTextAlignmentLeft;
//    }
//}

- (void) configCell {
    self.maxDecimalPlaces = 0;
    _autoCorrectionType = UITextAutocorrectionTypeNo;
    _autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textAlignment = NSTextAlignmentLeft;
    _textfieldInputType = APStringInputTypeFreeText;
    _textColor = [UIColor grayColor];
    //_clearButtonMode = UITextFieldViewModeNever;
    
    NSNumberFormatter *formatter = [NSNumber sharedFormatter];
    self.decimalSeparator = formatter.decimalSeparator;
    
    [self.contentView addSubview:self.textField];
    
    //_textInsetFromLeftMargin = 100;
    
    // Minimum height
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:43.5]];
    
    // Make the textfield height the same as the cell
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textField]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{@"textField":self.textField}]];
    // Horizontal alignement including insets
    self.textFielHorizontalContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-inset-[textField]-inset-|"
                                                                                options:0
                                                                                metrics:@{@"inset":@(kAPTextFieldHorizontalInset)}
                                                                                  views:@{@"textField":self.textField}];
    
    [self.contentView addConstraints:self.textFielHorizontalContraints];
}


#pragma mark - Getter and Setters

- (void) setCellDidEditBlock: (void (^) (NSString* text)) block {
    _cellDidEdit = block;
}


- (void) setCellDidClickReturnBlock: (void (^) (void)) block {
    _cellDidClickReturn = block;
}


- (UITextField*) textField {
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.delegate = self;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.textAlignment = self.textAlignment;
        _textField.textColor = self.textColor;
        [_textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _textField;
}


//- (void) setPrefixText:(NSString *)prefixText {
//    if (prefixText) {
//        
//        UILabel* prefixTextLabel = [UILabel new];
//        prefixTextLabel.numberOfLines = 0;
//        prefixTextLabel.textColor = self.prefixTextColor ?: [UIColor blackColor];
//        prefixTextLabel.text = prefixText;
//        [prefixTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [prefixTextLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//        [self.contentView addSubview:prefixTextLabel];
//        self.prefixTextLabel = prefixTextLabel;
//        
//        [self.contentView removeConstraints:self.textFielHorizontalContraints];
//        
//        NSDictionary* viewsDict = @{@"headerLabel":prefixTextLabel,
//                                    @"textField":self.textField};
//        
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerLabel]|"
//                                                                                 options:0
//                                                                                 metrics:nil
//                                                                                   views:viewsDict]];
//        
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-inset-[headerLabel]"
//                                                                                 options:0
//                                                                                 metrics:@{@"inset":@(15)}
//                                                                                   views:viewsDict]];
//        
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leftSpaceInset-[textField]-inset-|"
//                                                                                 options:0
//                                                                                 metrics:@{@"inset":@(kAPTextFieldHorizontalInset),
//                                                                                           @"leftSpaceInset":@(self.textInsetFromLeftMargin)}
//                                                                                   views:viewsDict]];
//    }
//    _prefixText = prefixText;
//}

- (void) setPrefixText:(NSString *)prefixText {
    _prefixText = prefixText;
    UILabel* prefixTextLabel = [UILabel new];
    prefixTextLabel.textColor = self.textField.textColor;
    prefixTextLabel.font = self.textField.font;
    prefixTextLabel.text = prefixText;
    prefixTextLabel.textColor = self.prefixTextColor;
    prefixTextLabel.textAlignment = NSTextAlignmentLeft;
    [prefixTextLabel sizeToFit];
    self.textField.leftView = prefixTextLabel;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void) setPrefixTextMiniumWidth:(CGFloat)prefixTextMiniumWidth {
    _prefixTextMiniumWidth = prefixTextMiniumWidth;
    CGRect frame = self.textField.leftView.frame;
    frame.size.width = 150;
    self.textField.leftView.frame = frame;
}


- (void) setSufixText:(NSString *)sufixText {
    _sufixText = sufixText;
    UILabel* prefixTextLabel = [UILabel new];
    prefixTextLabel.textColor = self.textField.textColor;
    prefixTextLabel.font = self.textField.font;
    prefixTextLabel.text = sufixText;
    [prefixTextLabel sizeToFit];
    self.textField.rightView = prefixTextLabel;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
}

//- (void) setPrefixTextColor:(UIColor *)prefixTextColor {
//    self.prefixTextLabel.textColor = prefixTextColor;
//    _prefixTextColor = prefixTextColor;
//}

- (void) setText:(NSString *)text {
    _text = text;
    self.textField.text = text;
}

- (void) setTextColor:(UIColor *)textColor {
    self.textField.textColor = textColor;
}

- (void) setReturnKeyType:(UIReturnKeyType)returnKeyType {
    _returnKeyType = returnKeyType;
    self.textField.returnKeyType = returnKeyType;
}

- (void) setAutocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType {
    _autocapitalizationType = autocapitalizationType;
    self.textField.autocapitalizationType = autocapitalizationType;
}

-(void) setAutoCorrectionType:(UITextAutocorrectionType)autoCorrectionType {
    _autoCorrectionType = autoCorrectionType;
    self.textField.autocorrectionType = autoCorrectionType;
    
}

- (void) setSecure:(BOOL)secure {
    self.textField.secureTextEntry = secure;
    self.textField.keyboardAppearance = UIKeyboardAppearanceDark;
    _secure = secure;
}

- (void) setTextfieldInputType:(APStringInputType)textfieldInputType {
    _textfieldInputType = textfieldInputType;
    
    switch (textfieldInputType) {
        
        case APStringInputTypeMoney:
        case APStringInputTypeNumberDecimal:
            self.textField.keyboardType = UIKeyboardTypeDecimalPad;
            self.maxDecimalPlaces = 2;
            break;
        
        case APStringInputTypeFreeText:
            self.textField.keyboardType = UIKeyboardTypeASCIICapable;
             break;
        
        case APStringInputTypeNumber:
            if (self.maxDecimalPlaces > 0) {
                self.textField.keyboardType = UIKeyboardTypeDecimalPad;
                
            } else {
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
            }
             break;
            
        case APStringInputTypeMonth:
        case APStringInputTypeYear:
            self.textField.inputView = [self pickerView];
            
        default:
            break;
    }
}

- (void) setCellDidClickReturn:(void (^)(void))cellDidClickReturn {
    _cellDidClickReturn = cellDidClickReturn;
    switch (self.textfieldInputType) {
            
        case APStringInputTypeMoney:
        case APStringInputTypeNumberDecimal:
        case APStringInputTypeNumber:
        case APStringInputTypeMonth:
        case APStringInputTypeYear:
            if (self.cellDidClickReturn) {
                self.textField.inputAccessoryView = [self pickerAccessoryView];
            }
            break;
        default:
            self.textField.inputAccessoryView = nil;
    }
}

- (UIToolbar*) pickerAccessoryView {
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           
    [[UIBarButtonItem alloc]initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    return numberToolbar;
}

- (void) doneWithNumberPad {
    if (self.cellDidClickReturn) self.cellDidClickReturn();
}


- (UIPickerView*) pickerView {
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    return pickerView;
}


#pragma mark - PickerView DataSource and Delegate

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.textfieldInputType == APStringInputTypeMonth) {
        return 12;
    } else {
        return 20;
    }
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.textfieldInputType == APStringInputTypeMonth) {
        return [NSString stringWithFormat:@"%ld",(long) row + 1];
    } else {
        return [NSString stringWithFormat:@"%ld",(long) row + 2015];
    }
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString* selectedTitle = [self pickerView:pickerView titleForRow:row forComponent:component];
    self.textField.text = selectedTitle;
    if (self.cellDidEdit) self.cellDidEdit(selectedTitle);
}

- (void) setMaxDecimalPlaces:(NSUInteger)maxDecimalPlaces {
    _maxDecimalPlaces = maxDecimalPlaces;
    
    if (self.textfieldInputType == APStringInputTypeNumber) {
        if (maxDecimalPlaces > 0) {
            [self.textField setKeyboardType:UIKeyboardTypeDecimalPad];
        } else {
            [self.textField setKeyboardType:UIKeyboardTypeNumberPad];
        }
    }
}

- (void) setPlaceHolderText:(NSString *)placeHolderText {
    _placeHolderText = placeHolderText;
    self.textField.placeholder = placeHolderText;
}

- (void) setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.textField.textAlignment = textAlignment;
}

- (void) setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
    self.textField.clearButtonMode = clearButtonMode;
}

- (UITextFieldViewMode) clearButtonMode {
    return self.textField.clearButtonMode;
}

- (void) setInputAccessoryView:(UIView *)inputAccessoryView {
    self.textField.inputAccessoryView = inputAccessoryView;
}


- (BOOL) becomeFirstResponder {
    [super becomeFirstResponder];
    [self.textField becomeFirstResponder];
    return YES;
}

- (BOOL) resignFirstResponder {
    [super resignFirstResponder];
    [self.textField resignFirstResponder];
    return YES;
}

#pragma UITextFieldDelegate

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // Validar o que foi digitado
    if (string.length > 0) {
        if (self.textfieldInputType == APStringInputTypeMoney ||
            self.textfieldInputType == APStringInputTypeNumber ||
            self.textfieldInputType == APStringInputTypeNumberDecimal) {
                
            // Caso não seja numero nem "," então não é válido
            if (isnumber([string characterAtIndex:0]) == NO && [string isEqualToString:self.decimalSeparator] == NO)
                return NO;
            
            // Não deixar ter mais caracteres que o permitido nas casas decimais
            NSArray* numberComponents = [textField.text componentsSeparatedByString:self.decimalSeparator];
            if ([numberComponents count] == 2) {
                NSString* decimalPart = [numberComponents lastObject];
                
                if ([decimalPart length] >= self.maxDecimalPlaces)
                    return NO;
            }
            
            //Decimal separator (, ou .)
            if ([string isEqualToString:self.decimalSeparator]){
                
                // Não pode ter mais que um separador
                if ([textField.text numberOfOccurenciesOfString:self.decimalSeparator] > 0) {
                    return NO;
                }
                
                // Não pode ser o primeiro caracter
                if ([textField.text length] == 0) {
                    return NO;
                }
            }
        }
    }
    
    if (self.cellDidEdit) {
        // Executa block com o valor atual do textField
        self.cellDidEdit([textField.text stringByReplacingCharactersInRange:range withString:string]);
    }
    
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (self.cellDidClickReturn) {
        self.cellDidClickReturn();
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}


- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.didBecomeFirstResponder) self.didBecomeFirstResponder();
    return YES;
}


//
//- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
//    if (self.isEditing) {
//        return YES;
//    } else {
//        return NO;
//    }
//}


@end
