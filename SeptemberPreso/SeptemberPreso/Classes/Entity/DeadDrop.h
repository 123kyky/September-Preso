//
//  DeadDrop.h
//  SeptemberPreso
//
//  Created by Kyle Roberts on 9/1/13.
//  Copyright (c) 2013 Kyle Roberts. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface DeadDrop : NSManagedObject

@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSString *name;

@end
