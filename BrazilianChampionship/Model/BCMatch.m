//
//  BCMatch.m
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "BCMatch.h"

@implementation BCMatch

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"code": @"id",
             @"homeTeamScore": @"home_team_score",
             @"visitorTeamScore": @"away_team_score",
             @"mDate": @"date",
             @"location": @"place",
             @"round": @"round",
             @"seasonCode": @"season_id",
             @"homeTeam": @"home_team",
             @"visitorTeam": @"away_team"
             };
}

@end
