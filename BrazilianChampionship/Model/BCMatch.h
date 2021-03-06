//
//  BCMatch.h
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "BCTeam.h"

@interface BCMatch : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) NSNumber *homeTeamScore;
@property (nonatomic, copy) NSNumber *visitorTeamScore;
@property (nonatomic, copy) NSDate *mDate;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSNumber *mRound;
@property (nonatomic, copy) NSNumber *seasonCode;
@property (nonatomic, copy) BCTeam *homeTeam;
@property (nonatomic, copy) BCTeam *visitorTeam;

- (NSString *)formattedDate;

@end
