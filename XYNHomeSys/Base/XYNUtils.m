//
//  XYNUtils.m
//  XYNHomeSys
//
//  Created by xyn on 2021/3/4.
//

#import "XYNUtils.h"

@implementation XYNUtils
#pragma mark - 十六进制颜色值转换成UIColor对象
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
#pragma mark - 颜色转换为字符串
//+ (NSString *)changeUIColorToRGB:(UIColor *)color{
//    const CGFloat *cs=CGColorGetComponents(color.CGColor);
//    NSString *r = [NSString stringWithFormat:@"%@",[self  ToHex:cs[0]*255]];
//    NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
//    NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
//    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
//}
// 使用UIColor创建UIImage
+ (UIImage *)createImageWithColor: (UIColor *)color;{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
