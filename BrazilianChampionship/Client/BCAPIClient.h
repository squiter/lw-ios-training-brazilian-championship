//
//  BCAPIClient.h
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "BCTeam.h"
#import "BCMatch.h"

typedef void(^APIClientTeamsBlockDef)(NSArray <BCTeam *> *teams, NSInteger statusCode, NSError *error);
typedef void(^APIClientMatchesBlockDef)(NSArray <BCMatch *> *matches, NSInteger statusCode, NSError *error);

@interface BCAPIClient : AFHTTPSessionManager

+ (NSURLSessionTask *)fetchTeams:(APIClientTeamsBlockDef)completion;
+ (NSURLSessionTask *)fetchMatches:(APIClientMatchesBlockDef)completion;

@end
