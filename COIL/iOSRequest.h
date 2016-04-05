/************************************************************
*                                                           *
*   file name   : iOSRequest.h                              *
*                                                           *
*   folder name : RealEstate1691                            *
*                                                           *
*   Created by binit on 26/06/15.                           *
*                                                           *
*   Copyright (c) 2015 Code Brew Labs. All rights reserved. *
*                                                           *
************************************************************/

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface iOSRequest : NSObject

+(void)getJSONRespone :(NSString *)urlStr : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure ;

+(void)postMutliPartData : (NSString *)urlStr : (NSString *)keyName : (NSDictionary *)parameters : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;
//
//+(void)postEmoticons : (NSString *)url parameters:(NSDictionary *)dparameters  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure;

+(void)postData : (NSString *)urlStr : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)postImages : (NSDictionary *)parameters imageData:(NSArray *)imageArr url:(NSString *)urlStr success : (void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure;

@end