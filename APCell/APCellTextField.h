//
//  APTextFieldTableViewCell.h
//  MilkMap
//
//  Created by Flavio Torres on 07/08/13.
//  Copyright (c) 2013 Apetis. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, APStringInputType) {
    APStringInputTypeFreeText = 0,
    APStringInputTypeNumber,
    APStringInputTypeNumberDecimal,
    APStringInputTypeMoney
};


@interface APCellTextField : UITableViewCell

/// Default is APStringInputTypeFreeText
@property (nonatomic, assign) APStringInputType textfieldInputType;

/// conteúdo inicial da celula (placeholder)
@property (nonatomic,copy) NSString* placeHolderText;

/// Text que ficará no lado esquerdo da celula
@property (nonatomic,copy) NSString* prefixText;
@property (nonatomic,strong) UIColor* prefixTextColor;

/// Default is 0, if textfieldInputType == APStringInputTypeMoney or APStringInputTypeNumberDecimal then it will 2
@property (nonatomic,assign) NSUInteger maxDecimalPlaces;

/// Text editado pelo usuário
@property (nonatomic,copy) NSString* text;

/// Default is graycolor
@property (nonatomic,strong) UIColor* textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;

/// Space from left margin to textfield. Default is 8
@property (nonatomic, assign) NSInteger textInsetFromLeftMargin;

/// Retorna o que o usuário editou usuário esta editando;
- (void) setCellDidEdit:(void (^)(NSString *text))block;

- (void) setDidBecomeFirstResponder:(void(^)(void)) block;

/// Bloco será executado quando o usuário apertear return no teclado, caso == nil some com o teclado
@property (nonatomic,copy) void (^cellDidClickReturn) (void);

@property (nonatomic,assign) UIReturnKeyType returnKeyType;

/// Default UITextAutocorrectionTypeNo
@property (nonatomic,assign) UITextAutocorrectionType autoCorrectionType;

/// Default UITextAutocapitalizationTypeNone
@property (nonatomic,assign) UITextAutocapitalizationType autocapitalizationType;

///
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;

@property (nonatomic, weak) UIView* inputAccessoryView;

@property (nonatomic,assign) BOOL secure;


@end

