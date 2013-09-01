//
//  DeadDropAnnotation.m
//  SeptemberPreso
//
//  Created by Kyle Roberts on 9/1/13.
//  Copyright (c) 2013 Kyle Roberts. All rights reserved.
//

#import "DeadDropAnnotation.h"

@implementation DeadDropAnnotation

- (id)initWithDeadDrop:(DeadDrop *)aSuperSpyDeadDrop {
    self = [super init];
    
    if (self) {
        _deadDrop = aSuperSpyDeadDrop;
        _coordinate = CLLocationCoordinate2DMake([aSuperSpyDeadDrop.latitude doubleValue],
                                                 [aSuperSpyDeadDrop.longitude doubleValue]);
        _title = aSuperSpyDeadDrop.name;
    }
    
    return self;
}

@end
