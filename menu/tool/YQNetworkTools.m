
//  Created by yang on 15/11/19.
//  Copyright © 2015年 yang. All rights reserved.
//

#import "YQNetworkTools.h"
#import "AppDelegate.h"
//#import "SVProgressHUD.h"
@implementation YQNetworkTools
+ (instancetype)sharedTools
{
    static YQNetworkTools* tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL* url = [NSURL URLWithString:@""];
        tools = [[self alloc] initWithBaseURL:url];
        
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"GeoTrust Global CA" ofType:@"cer"];
        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        securityPolicy.pinnedCertificates=certSet;
        securityPolicy.allowInvalidCertificates=NO;
        securityPolicy.validatesDomainName=YES;
        
        tools.responseSerializer = [AFHTTPResponseSerializer serializer];
        tools.securityPolicy =securityPolicy;

    });
    return tools;
}
//-(BOOL)HttpState{
//    if ([DEF_PERSISTENT_GET_OBJECT(@"networkJoinState") isEqualToString:@"1"] ||
//        [DEF_PERSISTENT_GET_OBJECT(@"networkJoinState") isEqualToString:@"2"]) {
//        return YES;
//    }else{
//        return NO;
//    }
//}
- (void)requestJsonDict:(HTTPMethod)method urlString:(NSString*)urlString parameters:(NSDictionary*)parameters finished:(void (^)(id dict, NSError* error))finished
{
    NSLog(@"请求地址。%@",urlString);
    NSLog(@"请求参数打印 %@",parameters);
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
//    NSString *sign = @"e155e1bb4a9c38e3baf90637ab7865df";
//    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.1.0",
//                                                 @"sign":sign,
//                                                 @"apptype":@"ios"
//                                                 };
//    if (headerFieldValueDictionary != nil) {
//        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
//            NSString *value = headerFieldValueDictionary[httpHeaderField];
//            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//        }
//    }
    self.requestSerializer = requestSerializer;
    if (method == POST) {
        [self POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
         
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            if (responseObject) {
                NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSLog(@"请求类 dict    %@",dict);
                finished(dict, nil);
                
            }
            else {
                
//                [SVProgressHUD showErrorWithStatus:@"数据错误"];
//                [SVProgressHUD dismiss];
//                [MBManager showBriefAlert:@"数据错误"];
                NSLog(@"数据错误");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             finished(nil, error);
            
//            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
//            [SVProgressHUD dismiss];
//            [MBManager showBriefAlert:@"连接服务器失败"];
            NSLog(@"连接服务器失败");
        }];
    }
    else {
        [self GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                finished(dict, nil);
            }
            else {
//                 [SVProgressHUD showErrorWithStatus:@"数据错误"];
//                [SVProgressHUD dismiss];
//                [MBManager showBriefAlert:@"连接服务器失败"];
                NSLog(@"连接服务器失败");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil, error);
//            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
//            [SVProgressHUD dismiss];
//            [MBManager showBriefAlert:@"连接服务器失败"];
            NSLog(@"连接服务器失败");
        }];
    }
    
}
- (void)requestSHANGJINJsonDict:(HTTPMethod)method urlString:(NSString*)urlString parameters:(NSDictionary*)parameters finished:(void (^)(id dict, NSError* error))finished{
    NSLog(@"请求地址   %@",urlString);
    NSLog(@"请求参数。 %@",parameters);
    if (method == POST) {
        [self POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (responseObject) {
                NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                finished(dict, nil);
                
            }
            else {
                
                //                [MBProgressHUD showError:@"数据错误"];
                NSLog(@"数据错误");
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil, error);
            
            //            [AppDelegate showHUDAndHide:@"连接服务器失败" view:[AppDelegate appdelegate].window];
            NSLog(@"连接服务器失败");
        }];
    }
    else {
        [self GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                finished(dict, nil);
            }
            else {
                NSLog(@"数据错误");
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            finished(nil, error);
        }];
    }
}
- (void)uplaodImageUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters Images:(NSMutableArray *)images andImageParameter:(NSMutableArray *)imageParameter  finished:(void (^)(NSDictionary* reulst,NSError *error))finished{
//    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSLog(@"%@",parameters);
    
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    NSString *sign = @"e155e1bb4a9c38e3baf90637ab7865df";
    //[SignOfMD5 signStringOfMD5:@"life"];
    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.1.0",
                                                 @"sign":sign,
                                                 @"apptype":@"ios"
                                                 };
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    self.requestSerializer = requestSerializer;
  
    [self POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<images.count; i++) {
            //注意图片格式转换
            [formData appendPartWithFileData:images[i] name:imageParameter[i] fileName:[NSString stringWithFormat:@"pictureUrl%d.jpg",i+1] mimeType:@"image/jpeg"];
//            NSLog(@"image = %@",imageParameter[i]);
        }

//        for (int i=0; i<images.count; i++) {
//            [formData appendPartWithFileData:images[i] name:imageParameter[i] fileName:[NSString stringWithFormat:@"pictureUrl%d.png",i+1] mimeType:@"image/png"];
//            
//            
//            
////            [formData appendPartWithFileData:eachImgData name:[NSString stringWithFormat:@"img%d", i+1] fileName:[NSString stringWithFormat:@"img%d.jpg", i+1] mimeType:@"image/jpeg"];
//            /*
//            执行这个方法时， name：部分是服务器用来解析的字段， 而fileName则是直接上传上去的图片， 注意一定要加 .jpg或者.png，（这个根据你得到这个imgData是通过jepg还是png的方式来获取决定）。 然后mimeType值也要与上面的类型对应， 网上看到有的说直接写成 @"image/*"， 据说也是可以的， 没验证过。
//            但一定要注意的是这个fileName中.jpg和.png是一定要添加的。 否则服务器可能会推断这个图片的类型， 推断时就可能推断错误，
//             
//            [formData appendPartWithFileData:images[i] name:[NSString stringWithFormat:@"img%d", i+1] fileName:imageParameter[i] mimeType:@"image/png"];
//            
//            */
//            
//            
////            NSLog(@"image = %@",imageParameter[i]);
//        }
//        [formData appendPartWithFileData:images[0] name:@"iconDate" fileName:@"image.jpg" mimeType:@"image/jpeg"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"%@",dict);
        finished(dict,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(nil,error);
    }];
}
-(void)uplaodVideoUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters Videos:(NSMutableArray *)Videos andImageParameter:(NSMutableArray *)imageParameter finished:(void (^)(NSDictionary *, NSError *))finished{
    NSLog(@"地址。%@",urlString);
    NSLog(@"参数。%@",parameters);
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    NSString *sign = @"e155e1bb4a9c38e3baf90637ab7865df";
    //[SignOfMD5 signStringOfMD5:@"life"];
    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.1.0",
                                                 @"sign":sign,
                                                 @"apptype":@"ios"
                                                 };
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    self.requestSerializer = requestSerializer;
    
    [self POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<Videos.count; i++) {
            //注意图片格式转换
            [formData appendPartWithFileData:Videos[i] name:imageParameter[i] fileName:[NSString stringWithFormat:@"pictureUrl%d.mp4",i+1] mimeType:@"video/mp4"];
            //            NSLog(@"image = %@",imageParameter[i]);
        }
        
        //        for (int i=0; i<images.count; i++) {
        //            [formData appendPartWithFileData:images[i] name:imageParameter[i] fileName:[NSString stringWithFormat:@"pictureUrl%d.png",i+1] mimeType:@"image/png"];
        //
        //
        //
        ////            [formData appendPartWithFileData:eachImgData name:[NSString stringWithFormat:@"img%d", i+1] fileName:[NSString stringWithFormat:@"img%d.jpg", i+1] mimeType:@"image/jpeg"];
        //            /*
        //            执行这个方法时， name：部分是服务器用来解析的字段， 而fileName则是直接上传上去的图片， 注意一定要加 .jpg或者.png，（这个根据你得到这个imgData是通过jepg还是png的方式来获取决定）。 然后mimeType值也要与上面的类型对应， 网上看到有的说直接写成 @"image/*"， 据说也是可以的， 没验证过。
        //            但一定要注意的是这个fileName中.jpg和.png是一定要添加的。 否则服务器可能会推断这个图片的类型， 推断时就可能推断错误，
        //
        //            [formData appendPartWithFileData:images[i] name:[NSString stringWithFormat:@"img%d", i+1] fileName:imageParameter[i] mimeType:@"image/png"];
        //
        //            */
        //
        //
        ////            NSLog(@"image = %@",imageParameter[i]);
        //        }
        //        [formData appendPartWithFileData:images[0] name:@"iconDate" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        finished(dict,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(nil,error);
        NSLog(@"出错");
    }];
}
@end
