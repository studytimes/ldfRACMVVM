//
//  LdfNetWorkingClient.h
//  ldfRACMVVM
//
//  Created by aigegou on 2017/2/27.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DataDownloadCompletion)(id data, NSError *error);

@interface LdfNetWorkingClient : NSObject

+ (instancetype)sharedInstance;
/**
 * 普通的网络接口
 */
- (NSURLSessionDataTask *)requestForUrl:(NSString *)url withParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion;
/**
 * 文件的下载
 */
-(NSURLSessionDownloadTask*)downloadForUrl:(NSString *)url  withParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion;

@end
