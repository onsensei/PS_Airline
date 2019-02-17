//
//  DetailViewController.m
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"

@interface DetailViewController () {
    id flightResponse;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.airport.airportTh;
    
    NSString *urlString = @"http://27.254.94.164:30080/api/flight";
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:self.airport.icao forKey:@"airport_code"];
    [param setValue:@"A" forKey:@"flight_type"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self->flightResponse = responseObject;
        [self.flightTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
