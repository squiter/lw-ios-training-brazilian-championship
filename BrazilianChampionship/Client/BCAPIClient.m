//
//  BCAPIClient.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCAPIClient.h"

@implementation BCAPIClient

+ (instancetype)sharedClient {
    static BCAPIClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://mockbrasileirao.herokuapp.com/api"];
        instance = [[BCAPIClient alloc] initWithBaseURL:baseURL];
    });
    return instance;
}

+ (NSURLSessionTask *)fetchTeams:(APIClientTeamsBlockDef)completion {
    return [[self sharedClient] GET:@"teams"
                         parameters:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject)
    {
        NSArray *teams = [MTLJSONAdapter modelsOfClass:BCTeam.class
                                         fromJSONArray:responseObject[@"teams"]
                                                 error:nil];
                                
        NSHTTPURLResponse *response = (NSHTTPURLResponse *) task.response;
        completion(teams, response.statusCode, nil);
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        completion(nil, response.statusCode, error);
                                
    }];
}

+ (NSURLSessionTask *)fetchMatches:(APIClientMatchesBlockDef)completion {
    return [[self sharedClient] GET:@"matches"
                         parameters:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject)
            {
                NSArray *matches = [MTLJSONAdapter modelsOfClass:BCMatch.class
                                                 fromJSONArray:responseObject[@"matches"]
                                                         error:nil];
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse *) task.response;
                completion(matches, response.statusCode, nil);
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                completion(nil, response.statusCode, error);
                
            }];
}

@end
