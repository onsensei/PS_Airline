//
//  AirportTableViewCell.m
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import "AirportTableViewCell.h"

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
//    NSString *prefix = [object valueForKeyPath:@"prefix"];
//    NSString *icao = [object valueForKeyPath:@"icao"];
//    NSString *airport_en = [object valueForKeyPath:@"airport_en"];
    NSString *airport_th = [object valueForKeyPath:@"airport_th"];
    
    self.airportLabel.text = airport_th;
}

@end
