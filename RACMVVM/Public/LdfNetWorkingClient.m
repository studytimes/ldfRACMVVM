//
//  LdfNetWorkingClient.m
//  ldfRACMVVM
//
//  Created by aigegou on 2017/2/27.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import "LdfNetWorkingClient.h"

#include <AFHTTPSessionManager.h>

@interface LdfNetWorkingClient ()

@property (nonatomic,strong) NSString *clientType;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end
@implementation LdfNetWorkingClient

- (instancetype)init {
    [NSException raise:@"SingletonException" format:@"Http cannot be initialized using init"];
    
    return nil;
}

+ (instancetype)sharedInstance {
    static LdfNetWorkingClient *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithClientType:@"iOS"];
        
    });
    
    return sharedInstance;
}

- (instancetype)initWithClientType:(NSString *)clientType {
    if (self = [super init])
        self.clientType = clientType;
    self .manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    self.manager.requestSerializer.timeoutInterval=20.0;//时间设置
    
    return self;
}

- (NSURLSessionDataTask *)requestForUrl:(NSString *)url
                             withParams:(NSDictionary *)params
                             completion:(DataDownloadCompletion)completion {
    
    if (!completion) return nil;
    
    
    NSURLSessionDataTask *dataTask = [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|
                                        NSJSONReadingMutableLeaves error:nil];
#ifdef  DEBUG

        
#endif
        
       
       
        
        if ([Tools Object_IsNotBlank:dataDictionary[@"data"]]) {
            
            completion(dataDictionary,nil);
        }else{
            NSMutableDictionary *SetData=[NSMutableDictionary dictionaryWithDictionary:dataDictionary];
            [SetData setValue:[NSDictionary dictionary] forKey:@"data"];
            completion(SetData,nil);
            return;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil,error);
    }];
    return dataTask;
    
}
-(NSURLSessionDownloadTask*)downloadForUrl:(NSString *)url
                                withParams:(NSDictionary *)params
                                completion:(DataDownloadCompletion)completion{
    if (!completion) return nil;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task=[self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return nil;//url
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completion(response,nil);
    }];
    [task resume];
    return task;
}


@end

