//
//  AirportTableViewCell.m
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import "AirportTableViewCell.h"
#import "Airport.h"

@implementation AirportTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Command

- (void)refreshWithDataObject:(id)object {
    Airport *airport = object;
    self.airportLabel.text = airport.airportTh;
}

@end
