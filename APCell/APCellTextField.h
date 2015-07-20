//
//  APTextFieldTableViewCell.h
//  MilkMap
//
//  Created by Flavio Torres on 07/08/13.
//  Copyright (c) 2013 Apetis. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, APStringInputType) {
    APStringInputTypeFreeText = 0, //Default
    APStringInputTypeNumber,
    APStringInputTypeNumberDecimal,
    APStringInputTypeMoney,
    APStringInputTypeMonth,
    APStringInputTypeYear,
};


@interface APCellTextField : UITableViewCell

#pragma mark - Cell Configuration

/// Default is APStringInputTypeFreeText
@property (nonatomic, assign) APStringInputType textfieldInputType;

/// conteúdo inicial da celula (placeholder)
@property (nonatomic,copy) NSString* placeHolderText;

/// Text que ficará no lado esquerdo da textfield
@property (nonatomic,copy) NSString* prefixText;

/// Cor do texto que ficará no lado esquerdo da textfield
@property (nonatomic,strong) UIColor* prefixTextColor;

/// Use this property if you want to align the textfield of several cells.
@property (nonatomic, assign) CGFloat prefixTextMiniumWidth;

/// Texto que ficará no lado direito do textfield
@property (nonatomic,copy) NSString* sufixText;

/// Default is 0, if textfieldInputType == APStringInputTypeMoney or APStringInputTypeNumberDecimal then it will 2
@property (nonatomic,assign) NSUInteger maxDecimalPlaces;

/// The maximum numbers of characters accepted for the text property. Default is unlimited
@property (nonatomic,assign) NSUInteger maxTextLenght;

/// The maximum value accepted for the text property. This applies only for APStringInputTypeNumber,APStringInputTypeNumberDecimal,APStringInputTypeMoney.  Default is unlimited
@property (nonatomic,strong) NSNumber* maxTextValue;

/// Text editado pelo usuário
@property (nonatomic,copy) NSString* text;

/// Default is black color
@property (nonatomic,strong) UIColor* textColor;

/// Textfield text alignment, default is NSTextAlignmentLeft
@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic,assign) UIReturnKeyType returnKeyType;

/// Default UITextAutocorrectionTypeNo
@property (nonatomic,assign) UITextAutocorrectionType autoCorrectionType;

/// Default UITextAutocapitalizationTypeNone
@property (nonatomic,assign) UITextAutocapitalizationType autocapitalizationType;

///@see UITextFieldViewMode. Default is UITextFieldViewModeNever
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;

///@property (nonatomic, weak) UIView* inputAccessoryView;

@property (nonatomic,assign) BOOL secure;

///// Space from left margin to textfield. Default is 8
//@property (nonatomic, assign) NSInteger textInsetFromLeftMargin;

#pragma mark - Block call backs

/// Retorna o que o usuário editou usuário esta editando;
- (void) setCellDidEdit:(void (^)(NSString *text))block;

/// Block is called whenever the textfield becomes the first responder
- (void) setDidBecomeFirstResponder:(void(^)(void)) block;

/// Bloco será executado quando o usuário apertear return no teclado, caso == nil some com o teclado
- (void) setCellDidClickReturn:(void (^)(void))block;



@end

