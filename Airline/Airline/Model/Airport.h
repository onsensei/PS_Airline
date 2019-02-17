//
//  Airline.h
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Airport : NSObject

@property (nonatomic, retain) NSString *prefix;
@property (nonatomic, retain) NSString *icao;
@property (nonatomic, retain) NSString *airportEn;
@property (nonatomic, retain) NSString *airportTh;

@end

NS_ASSUME_NONNULL_END
