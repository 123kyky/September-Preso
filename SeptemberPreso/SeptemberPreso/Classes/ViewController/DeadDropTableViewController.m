//
//  DeadDropTableViewController.m
//  SeptemberPreso
//
//  Created by Kyle Roberts on 8/28/13.
//  Copyright (c) 2013 Kyle Roberts. All rights reserved.
//

#import "DeadDropTableViewController.h"

@interface DeadDropTableViewController ()

@end

@implementation DeadDropTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(38.637363, -90.232541);
    MKCoordinateSpan span = MKCoordinateSpanMake(5, 5);
    [_mapView setRegion:MKCoordinateRegionMake(coordinate, span) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
