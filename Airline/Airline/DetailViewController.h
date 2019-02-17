//
//  DetailViewController.h
//  Airline
//
//  Created by Thanaphat Suwannikornkul on 17/02/62 BE.
//  Copyright © 2562 Thanaphat Suwannikornkul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Airport.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, retain) Airport *airport;

@property (weak, nonatomic) IBOutlet UITableView *flightTableView;

@end

NS_ASSUME_NONNULL_END
