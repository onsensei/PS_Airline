//
//  DetailViewController.m
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"
#import "FlightTableViewCell.h"

@interface DetailViewController () {
    id flightResponse;
    NSString *mode; // can be = schedule OR status
    NSTimer* autoSwitchTimer;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.airport.airportTh;
    
    mode = @"schedule";
    
    NSString *urlString = @"http://27.254.94.164:30080/api/flight";
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:self.airport.icao forKey:@"airport_code"];
    [param setValue:@"A" forKey:@"flight_type"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self->flightResponse = responseObject;
        [self.flightTableView reloadData];
        
        // start timmer
        self->autoSwitchTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                                 target:self
                                                               selector:@selector(processAutoSwitchTimer:)
                                                               userInfo:nil
                                                                repeats:YES];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)processAutoSwitchTimer:(NSTimer*)timer {
    if ([mode isEqualToString:@"schedule"]) {
        mode = @"status";
    } else if ([mode isEqualToString:@"status"]) {
        mode = @"schedule";
    }
    
    [self.flightTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *flightList = [flightResponse valueForKeyPath:@"flightList"];
    return flightList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightTableViewCell *cell = (FlightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FlightTableViewCell"];
    if(cell == nil)
    {
        cell = [[FlightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FlightTableViewCell"];
    }
    
    NSArray *flightList = [flightResponse valueForKeyPath:@"flightList"];
    id flight = [flightList objectAtIndex:indexPath.row];
    
    [cell refreshWithDataObject:flight mode:mode];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
