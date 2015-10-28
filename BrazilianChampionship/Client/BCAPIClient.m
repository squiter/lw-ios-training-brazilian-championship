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
        NSURL *baseURL = [NSURL URLWithString:@"http://mockbrasileiro.herokuapps.com/api"];
        instance = [[BCAPIClient alloc] initWithBaseURL:baseURL];
    });
    return instance;
}

@end
