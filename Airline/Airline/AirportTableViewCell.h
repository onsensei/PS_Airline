//
//  AirportTableViewCell.h
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirportTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *airportIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *airportLabel;

#pragma mark - Command

- (void)refreshWithDataObject:(id)object;

@end

NS_ASSUME_NONNULL_END
