//
//  WebApiHandler.h
//  acromine
//
//  Created by Taranjit Lottey on 2/17/16.
//  Copyright © 2016 Taranjit Lottey. All rights reserved.
//


// *************************************************************************************************
// # MARK: Imports


#import <Foundation/Foundation.h>

#import "AFNetworking/AFNetworking.h"


// *************************************************************************************************
// # MARK: Typedef


typedef void (^WebApiResponse)(id response, id error);


// *************************************************************************************************
// # MARK: Interface


@interface WebApiHandler : NSObject


+ (id)sharedInstance;


- (void)getResultsForAcronym:(NSString *)acronym response:(WebApiResponse)response;


@end
