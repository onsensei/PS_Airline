//
//  FlightTableViewCell.h
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlightTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flightLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *flightIdLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusValueLabel;

#pragma mark - Command

- (void)refreshWithDataObject:(id)object mode:(NSString *)mode;

@end

NS_ASSUME_NONNULL_END
