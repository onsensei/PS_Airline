//
//  FlightTableViewCell.m
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import "FlightTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FlightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Command

- (void)refreshWithDataObject:(id)object mode:(NSString *)mode {
//    NSString *flightScheduleId = [object valueForKeyPath:@"flight_schedule_id"];
    NSString *flightId = [object valueForKeyPath:@"flight_id"];
//    NSString *icaoFlightId = [object valueForKeyPath:@"icao_flight_id"];
    NSString *statusTh = [object valueForKeyPath:@"status_th"];
//    NSString *statusEn = [object valueForKeyPath:@"status_en"];
//    NSString *statusColor = [object valueForKeyPath:@"status_color"];
//    NSString *airlineTh = [object valueForKeyPath:@"airline_th"];
//    NSString *airlineEn = [object valueForKeyPath:@"airline_en"];
    NSString *logo = [object valueForKeyPath:@"logo"];
//    NSString *icaoAirport = [object valueForKeyPath:@"icao_airport"];
//    NSString *airportEn = [object valueForKeyPath:@"airport_en"];
    NSString *airportTh = [object valueForKeyPath:@"airport_th"];
//    NSString *scheduleDate = [object valueForKeyPath:@"schedule_date"];
    NSString *scheduleTime = [object valueForKeyPath:@"schedule_time"];
    NSString *actualTime = [object valueForKeyPath:@"actual_time"];
    
    //----------
    
    NSString *imageUrlString = [NSString stringWithFormat:@"http://27.254.94.164:30080%@", logo];
    [self.flightLogoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString]
                                placeholderImage:nil];
    self.flightIdLabel.text = flightId;
    
    self.placeTitleLabel.text = @"จาก";
    self.placeNameLabel.text = airportTh;
    
    if ([mode isEqualToString:@"status"] && statusTh && statusTh.length > 0) {
        self.statusTitleLabel.text = statusTh;
        self.statusValueLabel.text = actualTime;
    } else {
        self.statusTitleLabel.text = @"ตารางเวลาบิน";
        self.statusValueLabel.text = scheduleTime;
    }
}

@end
