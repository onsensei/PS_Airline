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
#import "AirportResponse.h"
#import "Region.h"
#import "Airport.h"

@interface ViewController () {
    id rawAirportResponse;
    AirportResponse *masterAirportResponse;
    AirportResponse *airportResponse;
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
        self->rawAirportResponse = responseObject;
        self->masterAirportResponse = [self parseAirportResponseWithObject:responseObject];
        self->airportResponse = [self parseAirportResponseWithObject:responseObject];
        [self.airportTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (AirportResponse *)parseAirportResponseWithObject:(id)object {
    AirportResponse *airportResponse = [[AirportResponse alloc] init];
    airportResponse.lastUpdate = [object valueForKeyPath:@"last_update"];
    
    NSMutableArray *regionList = [[NSMutableArray alloc] init];
    airportResponse.regionList = regionList;
    
    //----------
    
    NSArray *rawRegionList = [object valueForKeyPath:@"region_list"];
    for (int i = 0; i < rawRegionList.count; i++) {
        id rawRegion = [rawRegionList objectAtIndex:i];
        
        Region *tmpRegion = [[Region alloc] init];
        tmpRegion.regionEn = [rawRegion valueForKeyPath:@"region_en"];
        tmpRegion.regionTh = [rawRegion valueForKeyPath:@"region_th"];
        
        NSMutableArray *airportList = [[NSMutableArray alloc] init];
        tmpRegion.airportList = airportList;
        
        //----------
        
        NSArray *rawAirportList = [rawRegion valueForKeyPath:@"airport_list"];
        for (int j = 0; j < rawAirportList.count; j++) {
            id rawAirport = [rawAirportList objectAtIndex:j];
            
            Airport *airport = [[Airport alloc] init];
            airport.prefix = [rawAirport valueForKeyPath:@"prefix"];
            airport.icao = [rawAirport valueForKeyPath:@"icao"];
            airport.airportEn = [rawAirport valueForKeyPath:@"airport_en"];
            airport.airportTh = [rawAirport valueForKeyPath:@"airport_th"];
            
            [airportList addObject:airport];
        }
        
        //----------
        
        [regionList addObject:tmpRegion];
    }
    
    return airportResponse;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"list_to_detail"]) {
        DetailViewController *vc = [segue destinationViewController];
        Airport *airport = sender;
        vc.airport = airport;
    }
}

#pragma mark - UITextFieldDelegate

- (IBAction)searchTextField_EditingChanged:(id)sender {
    if (self.searchTextField.text && self.searchTextField.text.length == 0) {
        airportResponse = [self parseAirportResponseWithObject:rawAirportResponse];
        [self.airportTableView reloadData];
    } else {
        AirportResponse *newResponse = [[AirportResponse alloc] init];
        newResponse.lastUpdate = masterAirportResponse.lastUpdate;
        newResponse.regionList = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < masterAirportResponse.regionList.count; i++) {
            Region *tmpRegion = [masterAirportResponse.regionList objectAtIndex:i];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(airportTh CONTAINS[cd] %@)", self.searchTextField.text];
            NSArray *filteredAirportList = [tmpRegion.airportList filteredArrayUsingPredicate:predicate];
            if (filteredAirportList.count > 0) {
                Region *newRegion = [[Region alloc] init];
                newRegion.regionEn = tmpRegion.regionEn;
                newRegion.regionTh = tmpRegion.regionTh;
                newRegion.airportList = [[NSMutableArray alloc] initWithArray:filteredAirportList];
                [newResponse.regionList addObject:newRegion];
            }
        }
        
        airportResponse = newResponse;
        [self.airportTableView reloadData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return airportResponse.regionList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Region *region = [airportResponse.regionList objectAtIndex:section];
    return region.regionTh;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Region *region = [airportResponse.regionList objectAtIndex:section];
    return region.airportList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AirportTableViewCell *cell = (AirportTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AirportTableViewCell"];
    if(cell == nil)
    {
        cell = [[AirportTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AirportTableViewCell"];
    }
    
    Region *region = [airportResponse.regionList objectAtIndex:indexPath.section];
    Airport *airport = [region.airportList objectAtIndex:indexPath.row];
    [cell refreshWithDataObject:airport];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Region *region = [airportResponse.regionList objectAtIndex:indexPath.section];
    Airport *airport = [region.airportList objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"list_to_detail" sender:airport];
}

@end
