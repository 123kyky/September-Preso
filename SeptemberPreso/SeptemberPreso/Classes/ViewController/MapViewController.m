//
//  MapViewController.m
//  SeptemberPreso
//
//  Created by Kyle Roberts on 9/2/13.
//  Copyright (c) 2013 Kyle Roberts. All rights reserved.
//

#import "MapViewController.h"
#import "DeadDrop.h"
#import "DeadDropAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController {
    CGRect onScreenMapFrame;
    CGRect nextMapFrame;
    CGRect previousMapFrame;
    
    NSManagedObjectContext *context;
    NSArray *deadDrops;
    
    MKMapView *_otherMapView;
    
    UILabel *label;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.accessibilityIdentifier = @"DeadDropMapScreen";
	self.mapView.accessibilityIdentifier = @"DeadDropMap";

    //setup frames for animation
    onScreenMapFrame = _mapView.frame;
    nextMapFrame = CGRectMake(onScreenMapFrame.size.width,
                              0,
                              onScreenMapFrame.size.width,
                              onScreenMapFrame.size.height);
    previousMapFrame = CGRectMake(0 - onScreenMapFrame.size.width,
                                  0,
                                  onScreenMapFrame.size.width,
                                  onScreenMapFrame.size.height);
    
    //setup mapviews
    _otherMapView = [[MKMapView alloc] initWithFrame:nextMapFrame];
    [self.view addSubview:_otherMapView];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(38.637363, -90.232541);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.22f, 0.22f);
    [_mapView setRegion:MKCoordinateRegionMake(coordinate, span) animated:YES];
    [_otherMapView setRegion:MKCoordinateRegionMake(coordinate, span)];
    
    [_mapView addAnnotation:_annotation];
    
    //setup label
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
	[label setIsAccessibilityElement:YES];
	label.accessibilityIdentifier = @"DeadDropMapTitle";
    label.textAlignment = NSTextAlignmentCenter;
    UIColor *blueishColor = [UIColor colorWithRed:155.0f/255.0f
                                            green:212.0f/255.0f
                                             blue:255.0f/255.0f
                                            alpha:1.0f];
    label.backgroundColor = blueishColor;
    [self.view addSubview:label];
    label.text = _annotation.deadDrop.name;
    
    //setup data
    context = [NSManagedObjectContext MR_defaultContext];
    deadDrops = [DeadDrop MR_findAllSortedBy:@"name" ascending:YES inContext:context];
    
    //setup buttons
    CGRect buttonFrame = CGRectMake(0, 0, 20, onScreenMapFrame.size.height);
    UIButton *leftButton = [[UIButton alloc] initWithFrame:buttonFrame];
	leftButton.accessibilityIdentifier = @"NavigateLeftButton";
    [leftButton addTarget:self
               action:@selector(showPreviousMap:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    buttonFrame = CGRectMake(onScreenMapFrame.size.width - 20, 0, 20, onScreenMapFrame.size.height);
    UIButton *rightButton = [[UIButton alloc] initWithFrame:buttonFrame];
	rightButton.accessibilityIdentifier = @"NavigateRightButton";
    [rightButton addTarget:self
                   action:@selector(showNextMap:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:label.frame];
    backButton.accessibilityIdentifier = @"NavigateBackButton";
    [backButton addTarget:self
                    action:@selector(backButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIActions

- (void)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showPreviousMap:(id)sender {
    if (_mapView.frame.origin.x == onScreenMapFrame.origin.x) {
        //set frame for animation
        _otherMapView.frame = previousMapFrame;
        
        //create new annotation and add it to the other map
        DeadDropAnnotation *currentAnnotation = _mapView.annotations[0];
        DeadDropAnnotation *newAnnotation = [self getNewAnnotaiton:NO withMap:_mapView];
        [_otherMapView addAnnotation:newAnnotation];
        
        [UIView animateWithDuration:0.7f animations:^{
            _mapView.frame = nextMapFrame;
            _otherMapView.frame = onScreenMapFrame;
        } completion:^(BOOL finished) {
            [self resetMapView:_mapView
                withAnnotation:currentAnnotation
                  andLabelText:newAnnotation.deadDrop.name];
        }];
    } else if (_otherMapView.frame.origin.x == onScreenMapFrame.origin.x) {
        //set frame for animation
        _mapView.frame = previousMapFrame;
        
        //create new annotation and add it to the map
        DeadDropAnnotation *currentAnnotation = _otherMapView.annotations[0];
        DeadDropAnnotation *newAnnotation = [self getNewAnnotaiton:NO withMap:_otherMapView];
        [_mapView addAnnotation:newAnnotation];
        
        [UIView animateWithDuration:0.7f animations:^{
            _otherMapView.frame = nextMapFrame;
            _mapView.frame = onScreenMapFrame;
        } completion:^(BOOL finished) {
            [self resetMapView:_otherMapView
                withAnnotation:currentAnnotation
                  andLabelText:newAnnotation.deadDrop.name];
        }];
    }
}

- (void)showNextMap:(id)sender {
    if (_mapView.frame.origin.x == onScreenMapFrame.origin.x) {
        //set frame for animation
        _otherMapView.frame = nextMapFrame;
        
        //create new annotation and add it to the other map
        DeadDropAnnotation *currentAnnotation = _mapView.annotations[0];
        DeadDropAnnotation *newAnnotation = [self getNewAnnotaiton:YES withMap:_mapView];
        [_otherMapView addAnnotation:newAnnotation];
        
        [UIView animateWithDuration:0.7f animations:^{
            _mapView.frame = previousMapFrame;
            _otherMapView.frame = onScreenMapFrame;
        } completion:^(BOOL finished) {
            [self resetMapView:_mapView
                withAnnotation:currentAnnotation
                  andLabelText:newAnnotation.deadDrop.name];
        }];
    } else if (_otherMapView.frame.origin.x == onScreenMapFrame.origin.x) {
        //set frame for animation
        _mapView.frame = nextMapFrame;
        
        //create new annotation and add it to the map
        DeadDropAnnotation *currentAnnotation = _otherMapView.annotations[0];
        DeadDropAnnotation *newAnnotation = [self getNewAnnotaiton:YES withMap:_otherMapView];
        [_mapView addAnnotation:newAnnotation];
        
        //animate
        [UIView animateWithDuration:0.7f animations:^{
            _otherMapView.frame = previousMapFrame;
            _mapView.frame = onScreenMapFrame;
        } completion:^(BOOL finished) {
            [self resetMapView:_otherMapView
                withAnnotation:currentAnnotation
                  andLabelText:newAnnotation.deadDrop.name];
        }];
    }
}

- (DeadDropAnnotation *)getNewAnnotaiton:(BOOL)next withMap:(MKMapView *)map {
    DeadDropAnnotation *newAnnotation;
    DeadDropAnnotation *currentAnnotation = map.annotations[0];
    if (next) { //next annotation
        int index = [deadDrops indexOfObject:currentAnnotation.deadDrop];
        if (index == deadDrops.count - 1) {
            index = 0;
        } else {
            index++;
        }
        
        newAnnotation = [[DeadDropAnnotation alloc] initWithDeadDrop:deadDrops[index]];
    } else { //previous annotation
        int index = [deadDrops indexOfObject:currentAnnotation.deadDrop];
        if (index == 0) {
            index = deadDrops.count - 1;
        } else {
            index--;
        }
        
        newAnnotation = [[DeadDropAnnotation alloc] initWithDeadDrop:deadDrops[index]];
    }

    return newAnnotation;
}

- (void)resetMapView:(MKMapView *)map
      withAnnotation:(DeadDropAnnotation *)annotation
        andLabelText:(NSString *)string {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(38.637363, -90.232541);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.22f, 0.22f);
    [map setRegion:MKCoordinateRegionMake(coordinate, span)];
    
    [map removeAnnotation:annotation];
    
    label.text = string;
}

@end
