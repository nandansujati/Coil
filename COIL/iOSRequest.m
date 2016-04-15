/************************************************************
*                                                           *
*   file name   : iOSRequest.m                              *
*                                                           *
*   folder name : RealEstate1691                            *
*                                                           *
*   Created by binit on 26/06/15.                           *
*                                                           *
*   Copyright (c) 2015 Code Brew Labs. All rights reserved. *
*                                                           *
************************************************************/

#import "iOSRequest.h"
#import "AFHTTPRequestOperation.h"

@implementation iOSRequest

+(void)getJSONRespone :(NSString *)urlStr : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    [manager GET:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)postMutliPartData : (NSString *)urlStr : (NSString *)keyName : (NSDictionary *)parameters : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if (data) {
             [formData appendPartWithFileData:data name:keyName fileName:@"temp.jpg" mimeType:@"image/jpg"];
         }
        

     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
         success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         failure(error);
     }];
}

+(void)postMutliPartVideoData : (NSString *)urlStr : (NSString *)keyName : (NSDictionary *)parameters : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if (data) {
             [formData appendPartWithFileData:data name:keyName fileName:@"temp.mp4" mimeType:@"image/mp4"];
         }
         
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         failure(error);
     }];
}


+(void)postData : (NSString *)urlStr : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {}
    success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
    }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failure(error);
    }];
}


+(void)getData : (NSString *)urlStr : (NSDictionary *)parameters : (void(^)(NSArray * response_success))success : (void(^)(NSError * response_error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {}
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
     }];
}


+(void)postImages : (NSDictionary *)parameters imageData:(NSArray *)imageArr url:(NSString *)urlStr success : (void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
         for (int i = 0; i < [imageArr count]; i++)
         {
             
             [formData appendPartWithFileData:UIImageJPEGRepresentation([imageArr objectAtIndex:i], 0.5) name:[NSString stringWithFormat:@"image[%d]",i] fileName:[NSString stringWithFormat:@"image%d.jpg",i] mimeType:@"image/jpeg"];
         }
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
         
         
         
         success(dict);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"%@",error);
         failure(error);
     }];
    
}

@end