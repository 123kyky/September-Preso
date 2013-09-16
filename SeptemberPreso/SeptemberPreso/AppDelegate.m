//
//  AppDelegate.m
//  SeptemberPreso
//
//  Created by Kyle Roberts on 8/28/13.
//  Copyright (c) 2013 Kyle Roberts. All rights reserved.
//

#import "AppDelegate.h"
#import "DeadDrop.h"

@implementation AppDelegate {
    NSManagedObjectContext *context;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [self.window makeKeyAndVisible];
    
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"SuperSpyDeadDrop.sqlite"];
    context = [NSManagedObjectContext MR_defaultContext];
    
    [self buildData];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [context MR_saveToPersistentStoreAndWait];
}

- (void)buildData {
    [DeadDrop MR_truncateAll];
    
    [self createDeadDropNamed:@"CocoaHeads" withLatitude:38.630048 andLongitude:-90.404772];
    [self createDeadDropNamed:@"Zoo" withLatitude:38.636283 andLongitude:-90.292109];
    [self createDeadDropNamed:@"Arch" withLatitude:38.624517 andLongitude:-90.184772];
    [self createDeadDropNamed:@"Busch Stadium" withLatitude:38.622372 andLongitude:-90.193269];
    [self createDeadDropNamed:@"Magic House" withLatitude:38.573896 andLongitude:-90.405275];
    [self createDeadDropNamed:@"Cathedral Basilica" withLatitude:38.642451 andLongitude:-90.254611];
    [self createDeadDropNamed:@"Mississippi River" withLatitude:38.621985 andLongitude:-90.181446];
    [self createDeadDropNamed:@"Illinois" withLatitude:38.615279 andLongitude:-90.129948];
    [self createDeadDropNamed:@"Lambert" withLatitude:38.748478 andLongitude:-90.36684];
    [self createDeadDropNamed:@"The Loop" withLatitude:38.655807 andLongitude:-90.304956];
    
    [context MR_saveOnlySelfAndWait];
}

- (DeadDrop *)createDeadDropNamed:(NSString *)name withLatitude:(double)latitude andLongitude:(double)longitude {
    DeadDrop *superSpyDeadDrop = [DeadDrop MR_createInContext:context];
    superSpyDeadDrop.name = name;
    superSpyDeadDrop.latitude = [NSNumber numberWithDouble:latitude];
    superSpyDeadDrop.longitude = [NSNumber numberWithDouble:longitude];
    
    return superSpyDeadDrop;
}

@end
