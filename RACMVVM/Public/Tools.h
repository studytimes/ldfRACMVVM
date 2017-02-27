//
//  Tools.h
//  DDgClient
//
//  Created by 刘伟 on 16/4/25.
//  Copyright © 2016年 hk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface Tools : NSObject


+ (CGSize)sizeOfString:(NSString *)string withFont:(UIFont *)font width:(CGFloat)width;

+ (BOOL)Object_IsNotBlank:(NSObject *)obj;

@end
