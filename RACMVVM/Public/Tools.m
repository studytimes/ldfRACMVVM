//
//  Tools.m
//  DDgClient
//
//  Created by 刘伟 on 16/4/25.
//  Copyright © 2016年 hk. All rights reserved.
//

#import "Tools.h"
@implementation Tools
+ (CGSize)sizeOfString:(NSString *)string withFont:(UIFont *)font width:(CGFloat)width {
    if ([NSNull null] == (id) string)
        return CGSizeZero;
    CGRect aframe = [string boundingRectWithSize:CGSizeMake(width, 0)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{
                                                   NSFontAttributeName : font
                                                   } context:nil];
    return aframe.size;
}

+(BOOL)Object_IsNotBlank:(id)obj{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objDic=(NSDictionary *)obj;
        if ([objDic allKeys].count==0) {
            return NO;
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *objArray=(NSArray *)obj;
        if (objArray.count==0) {
            return NO;
        }
    }
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *objString=(NSString *)obj;
        if (objString.length==0) {
            return NO;
        }
    }
    if (obj&&(![obj isKindOfClass:[NSNull class]])){
        return YES;
    }
    return NO;
}


@end
