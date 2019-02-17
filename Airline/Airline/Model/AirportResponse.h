//
//  RegionResponse.h
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirportResponse : NSObject

@property (nonatomic, retain) NSString *lastUpdate;
@property (nonatomic, retain) NSMutableArray *regionList;

@end

NS_ASSUME_NONNULL_END
