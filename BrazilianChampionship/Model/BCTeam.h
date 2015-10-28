//
//  BCTeam.h
//  BrazilianChampionship
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BCTeam : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageURL;

@end
