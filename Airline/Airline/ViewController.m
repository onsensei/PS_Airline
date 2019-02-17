//
//  ViewController.m
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "AFNetworking.h"
#import "AirportTableViewCell.h"
#import "Airport.h"

@interface ViewController () {
    id airportResponse;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Thai Flight Info";
    
    NSString *urlString = @"http://27.254.94.164:30080/api/airport";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self->airportResponse = responseObject;
        [self.airportTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"list_to_detail"]) {
        id rawAirport = sender;
        DetailViewController *vc = [segue destinationViewController];
        
        Airport *airport = [[Airport alloc] init];
        airport.prefix = [rawAirport valueForKeyPath:@"prefix"];
        airport.icao = [rawAirport valueForKeyPath:@"icao"];
        airport.airportEn = [rawAirport valueForKeyPath:@"airport_en"];
        airport.airportTh = [rawAirport valueForKeyPath:@"airport_th"];
        
        vc.airport = airport;
    }
}

#pragma mark - UITextFieldDelegate

- (IBAction)searchTextField_EditingChanged:(id)sender {
    //
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *regionList = [airportResponse valueForKeyPath:@"region_list"];
    return regionList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *regionList = [airportResponse valueForKeyPath:@"region_list"];
    id region = [regionList objectAtIndex:section];
//    NSString *region_en = [region valueForKeyPath:@"region_en"];
    NSString *region_th = [region valueForKeyPath:@"region_th"];
    
    return region_th;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *regionList = [airportResponse valueForKeyPath:@"region_list"];
    id region = [regionList objectAtIndex:section];
    NSArray *airport_list = [region valueForKeyPath:@"airport_list"];
    return airport_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AirportTableViewCell *cell = (AirportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AirportTableViewCell"];
    if(cell == nil)
    {
        cell = [[AirportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AirportTableViewCell"];
    }
    
    NSArray *regionList = [airportResponse valueForKeyPath:@"region_list"];
    id region = [regionList objectAtIndex:indexPath.section];
    NSArray *airport_list = [region valueForKeyPath:@"airport_list"];
    id airport = [airport_list objectAtIndex:indexPath.row];
    
    [cell refreshWithDataObject:airport];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *regionList = [airportResponse valueForKeyPath:@"region_list"];
    id region = [regionList objectAtIndex:indexPath.section];
    NSArray *airport_list = [region valueForKeyPath:@"airport_list"];
    id airport = [airport_list objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"list_to_detail" sender:airport];
}

@end
