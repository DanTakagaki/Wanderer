//
//  CoreDataManager.h
//  Wanderer
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FlickrPhotoDTO.h"

typedef void (^ResultBlock_t)(BOOL boolean , NSError* error);

@interface CoreDataManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedInstance;

- (void)saveContextWithCompletion:(ResultBlock_t) completion;

- (NSURL *)applicationDocumentsDirectory;
- (void)insertNewObjectWithDataDTO:(FlickrPhotoDTO*)modelDTO withResult:(ResultBlock_t) completion;
- (void)deleteObjectWithID:(NSString*)modelID withResult:(ResultBlock_t) completion;
- (void)existObjectWithDataDTO:(FlickrPhotoDTO*)modelDTO withResult:(ResultBlock_t) completion;
@end
