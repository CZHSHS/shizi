
//
//  Created by yang on 15/11/19.
//  Copyright © 2015年 yang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef enum:NSUInteger{
    POST,
     GET,
}HTTPMethod;

@interface YQNetworkTools : AFHTTPSessionManager
+ (instancetype)sharedTools;
- (void)requestJsonDict:(HTTPMethod)method urlString:(NSString *)urlString parameters:(NSDictionary *)parameters finished:(void (^)(id dict,NSError *error))finished;
//- (void)uplaodImageUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters imageData:(NSData*)imageData finished:(void (^)(NSDictionary* reulst,NSError *error))finished;
- (void)uplaodImageUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters Images:(NSMutableArray *)images andImageParameter:(NSMutableArray *)imageParameter  finished:(void (^)(NSDictionary* reulst,NSError *error))finished;
- (void)uplaodVideoUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters Videos:(NSMutableArray *)Videos andImageParameter:(NSMutableArray *)imageParameter  finished:(void (^)(NSDictionary* reulst,NSError *error))finished;
- (void)requestSHANGJINJsonDict:(HTTPMethod)method urlString:(NSString*)urlString parameters:(NSDictionary*)parameters finished:(void (^)(id dict, NSError* error))finished;
@end
