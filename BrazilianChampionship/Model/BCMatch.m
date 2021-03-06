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
             @"mRound": @"round",
             @"seasonCode": @"season_id",
             @"homeTeam": @"home_team",
             @"visitorTeam": @"away_team"
             };
}

#pragma mark - JSONTransformers
+ (NSValueTransformer *)mDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)homeTeamScoreJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *scoreNumber, BOOL *success, NSError *__autoreleasing *error) {
        return scoreNumber.integerValue == -1 ? nil : scoreNumber;
    }];
}

+ (NSValueTransformer *)visitorTeamScoreJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *scoreNumber, BOOL *success, NSError *__autoreleasing *error) {
        return scoreNumber.integerValue == -1 ? nil : scoreNumber;
    }];
}

#pragma mark - Date stuffs
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'";
    return dateFormatter;
}

- (NSString *)formattedDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"dd/MM HH:mm"];
    
    return (NSString *) [formatter stringFromDate:self.mDate];
}

@end
