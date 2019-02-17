//
//  ViewController.m
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "AirportTableViewCell.h"

@interface ViewController () {
    id airportResponse;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlString = @"http://27.254.94.164:30080/api/airport";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self->airportResponse = responseObject;
        [self.airportTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
