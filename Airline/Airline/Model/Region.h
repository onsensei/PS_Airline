//
//  Region.h
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Region : NSObject

@property (nonatomic, retain) NSString *regionEn;
@property (nonatomic, retain) NSString *regionTh;
@property (nonatomic, retain) NSMutableArray *airportList;

@end

NS_ASSUME_NONNULL_END
