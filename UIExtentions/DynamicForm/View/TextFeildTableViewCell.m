//
//  TextFeildTableViewCell.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "TextFeildTableViewCell.h"

@interface TextFeildTableViewCell()<UITextFieldDelegate>

@end

@implementation TextFeildTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _textFeild.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(GroupItems *)model{
    [super setModel:model];
    if (model.selectType == GroupItemSelectTypePhoneNumber || model.selectType == GroupItemSelectTypeNumber) {
        _textFeild.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }else{
        _textFeild.keyboardType = UIKeyboardTypeDefault;
    }
    _titleLabel.text = model.title;
    _textFeild.text = model.value;
    if (model.selectType == GroupItemSelectTypeACapitalText){
        _textFeild.keyboardType = UIKeyboardTypeASCIICapable;
        [_textFeild addTarget:self action:@selector(CarPlateWord:) forControlEvents:UIControlEventEditingChanged];
    }else if ( model.selectType == GroupItemSelectTypeVINCapitalText) {
        _textFeild.keyboardType = UIKeyboardTypeASCIICapable;
        [_textFeild addTarget:self action:@selector(CarPlateWord:) forControlEvents:UIControlEventEditingChanged];
    }else if ( model.selectType == GroupItemSelectTypePlateText) {
        [_textFeild addTarget:self action:@selector(CarPlateWord:) forControlEvents:UIControlEventEditingDidEnd];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textFeild resignFirstResponder];
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.model.selectType == GroupItemSelectTypePlateText) {
        self.model.value = textField.text;
        if ([self isCarCard:textField.text]) {
            if (_delegate && [_delegate respondsToSelector:@selector(TextFeildCellSection:row:text:)]) {
                [_delegate TextFeildCellSection:self.section row:self.row text:textField.text];
            }
        }else{
            [JGProgressHUD showErrorHUD:@"请输入正确车牌号"];
        }
    }else{
        self.model.value = textField.text;
        if (_delegate && [_delegate respondsToSelector:@selector(TextFeildCellSection:row:text:)]) {
            [_delegate TextFeildCellSection:self.section row:self.row text:textField.text];
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.model.selectType == GroupItemSelectTypeLegalText) {
        if ([self isInputRuleNotBlank:string] || [string isEqualToString:@""]) {//当输入符合规则和退格键时允许改变输入框
            return YES;
        } else {
            return NO;
        }
    }else if (self.model.selectType == GroupItemSelectTypePhoneNumber){
        if ([string isEqualToString:@""]) {
            return YES;
        }
        return textField.text.length <= 15;
    }else if (self.model.selectType == GroupItemSelectTypeVINCapitalText){
        if ([string isEqualToString:@""]) {
            return YES;
        }
        return textField.text.length < 17;
    }else{
        return YES;
    }
}

-(BOOL)isCarCard:(NSString *)str{
    NSString *pattern = @"^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-HJ-NP-Z0-9](([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-HJ-NP-Z0-9][A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳使领]))*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

-(void)CarPlateWord:(UITextField *)textFeild{
    if (self.model.selectType == GroupItemSelectTypeVINCapitalText) {
        NSString *str = [textFeild.text uppercaseString];
        str = [str stringByReplacingOccurrencesOfString:@"O" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"Q" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"I" withString:@""];
        textFeild.text = str;
    }else{
        textFeild.text = [textFeild.text uppercaseString];
    }
}


/**
 * 字母、数字、中文正则判断（不包括空格）
 */
- (BOOL)isInputRuleNotBlank:(NSString *)str {
    //NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSString *pattern = @"^[➋➌➍➎➏➐➑➒a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
//
///**
// * 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
// */
//- (BOOL)isInputRuleAndBlank:(NSString *)str {
//    //NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
//    NSString *pattern = @"^[➋➌➍➎➏➐➑➒a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:str];
//    return isMatch;
//}

/**
 *  获得 kMaxLength长度的字符
 */
-(NSString *)getSubString:(NSString*)string
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [string dataUsingEncoding:encoding];
    NSInteger length = [data length];
    if (length > 20) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(0, 20)];
        NSString *content = [[NSString alloc] initWithData:data1 encoding:encoding];//注意：当截取kMaxLength长度字符时把中文字符截断返回的content会是nil
        if (!content || content.length == 0) {
            data1 = [data subdataWithRange:NSMakeRange(0, 20 - 1)];
            content =  [[NSString alloc] initWithData:data1 encoding:encoding];
        }
        return content;
    }
    return nil;
}

- (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

@end
