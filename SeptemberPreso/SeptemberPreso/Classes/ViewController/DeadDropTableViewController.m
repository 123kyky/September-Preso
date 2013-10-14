//
//  DeadDropTableViewController.m
//  SeptemberPreso
//
//  Created by Kyle Roberts on 8/28/13.
//  Copyright (c) 2013 Kyle Roberts. All rights reserved.
//

#import "DeadDropTableViewController.h"
#import "DeadDrop.h"
#import "DeadDropAnnotation.h"
#import "MapViewController.h"

@interface DeadDropTableViewController ()

@end

@implementation DeadDropTableViewController {
    NSArray *deadDropTableData;
    NSManagedObjectContext *context;
    DeadDropAnnotation *annotation;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.accessibilityIdentifier = @"DeadDropListScreen";
    _tableView.accessibilityIdentifier = @"DeadDropList";
    _mapView.accessibilityIdentifier = @"DeadDropMiniMap";
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(38.637363, -90.232541);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.22f, 0.22f);
    [_mapView setRegion:MKCoordinateRegionMake(coordinate, span) animated:YES];
    
    UIButton *button = [[UIButton alloc] initWithFrame:_mapView.frame];
	button.accessibilityIdentifier = @"OpenMap";
    [button addTarget:self
               action:@selector(viewMapButtonTapped:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    context = [NSManagedObjectContext MR_defaultContext];
    deadDropTableData = [DeadDrop MR_findAllSortedBy:@"name" ascending:YES inContext:context];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View delegate/datasource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"DeadDropCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    DeadDrop *deadDrop = deadDropTableData[indexPath.row];
    cell.textLabel.text = deadDrop.name;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return deadDropTableData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showAnnotationForDeadDrop:deadDropTableData[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self removeAllAnnotations];
}

#pragma mark Annotation methods

- (void)showAnnotationForDeadDrop:(DeadDrop *)deadDrop {
    if (annotation) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[deadDropTableData indexOfObject:annotation.deadDrop]
                                                    inSection:0];
        [_tableView deselectRowAtIndexPath:indexPath animated:NO];
        [_mapView removeAnnotation:annotation];
    }
    
    annotation = [[DeadDropAnnotation alloc] initWithDeadDrop:deadDrop];
    [_mapView addAnnotation:annotation];
}

- (void)removeAllAnnotations {
    [_mapView removeAnnotation:annotation];
    annotation = nil;
}

#pragma mark Buttonz

- (void)viewMapButtonTapped:(UIButton *)sender {
    if (annotation) {
        [self performSegueWithIdentifier:@"mapViewSegue" sender:annotation];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapViewController *mapViewController = segue.destinationViewController;
    mapViewController.annotation = sender;
}

@end
