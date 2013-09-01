//
//  DeadDropAnnotation.h
//  SeptemberPreso
//
//  Created by Kyle Roberts on 9/1/13.
//  Copyright (c) 2013 Kyle Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DeadDrop.h"

@interface DeadDropAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) DeadDrop *deadDrop;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

- (id)initWithDeadDrop:(DeadDrop *)aSuperSpyDeadDrop;

@end
