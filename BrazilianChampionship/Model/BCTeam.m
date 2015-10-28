//
//  BCTeam.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "BCTeam.h"

@implementation BCTeam

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code": @"id",
             @"name": @"name",
             @"imageURL": @"logo_url"
             };
}

- (NSComparisonResult)compare:(BCTeam *)otherObject {
    return [self.name compare:otherObject.name];
}
@end
