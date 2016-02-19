//
//  WebApiHandler.m
//  acromine
//
//  Created by Taranjit Lottey on 2/17/16.
//  Copyright © 2016 Taranjit Lottey. All rights reserved.
//

#import "WebApiHandler.h"
#import "AFNetworking/AFHTTPSessionManager.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation WebApiHandler


// *************************************************************************************************
// # MARK: Shared Instance


+ (id)sharedInstance {
    static WebApiHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


// *************************************************************************************************
// # MARK: Private Methods


- (NSString *)_getUrlString {
    
    return @"http://www.nactem.ac.uk/software/acromine/dictionary.py";
}


- (NSDictionary *)_getParamsForAcronym:(NSString *)acronym {
   
    return @{@"sf":acronym};
}

// *************************************************************************************************
// # MARK: Public Methods


- (void)getResultsForAcronym:(NSString *)acronym response:(WebApiResponse)response {
    NSString *url_ = [self _getUrlString];
    NSDictionary *params = [self _getParamsForAcronym:acronym];
   
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    manager.responseSerializer.acceptableContentTypes = nil;
    
    [manager GET:url_ parameters:params progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             id data = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:kNilOptions
                                                                    error:nil];
             response (data, nil);
         }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            id errorJson = [NSJSONSerialization JSONObjectWithData: errorData
                                                                      options:kNilOptions
                                                                        error:nil];
            response (nil, errorJson);
    }];
}


@end
