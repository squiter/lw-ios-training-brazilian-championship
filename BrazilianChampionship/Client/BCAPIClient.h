//
//  BCAPIClient.h
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "BCTeam.h"

typedef void(^APIClientTeamsBlockDef)(NSArray <BCTeam *> *teams, NSInteger statusCode, NSError *error);

@interface BCAPIClient : AFHTTPSessionManager

+ (NSURLSessionTask *)fetchTeams:(APIClientTeamsBlockDef)completion;

@end
