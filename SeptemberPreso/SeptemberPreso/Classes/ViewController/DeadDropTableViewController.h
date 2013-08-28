//
//  DeadDropTableViewController.h
//  SeptemberPreso
//
//  Created by Kyle Roberts on 8/28/13.
//  Copyright (c) 2013 Kyle Roberts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DeadDropTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
