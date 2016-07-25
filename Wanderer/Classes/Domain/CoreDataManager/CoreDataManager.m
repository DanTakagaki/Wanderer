//
//  CoreDataManager.m
//  Wanderer
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

@implementation CoreDataManager

#pragma mark - Core Data stack

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static CoreDataManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [CoreDataManager new];
    });
    return sharedInstance;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Taka.Wanderer" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Wanderer" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Wanderer.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContextWithCompletion:(ResultBlock_t) completion
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        BOOL boolean = [managedObjectContext save:&error];
        if (!boolean) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
        
        completion(boolean);
    }
}

/*- (IBAction)findContact:(id)sender {
 CoreDataAppDelegate *appDelegate =
 [[UIApplication sharedApplication] delegate];
 
 NSManagedObjectContext *context =
 [appDelegate managedObjectContext];
 
 NSEntityDescription *entityDesc =
 [NSEntityDescription entityForName:@"Contacts"
 inManagedObjectContext:context];
 
 NSFetchRequest *request = [[NSFetchRequest alloc] init];
 [request setEntity:entityDesc];
 
 NSPredicate *pred =
 [NSPredicate predicateWithFormat:@"(name = %@)",
 _name.text];
 [request setPredicate:pred];
 NSManagedObject *matches = nil;
 
 NSError *error;
 NSArray *objects = [context executeFetchRequest:request
 error:&error];
 
 if ([objects count] == 0) {
 _status.text = @"No matches";
 } else {
 matches = objects[0];
 _address.text = [matches valueForKey:@"address"];
 _phone.text = [matches valueForKey:@"phone"];
 _status.text = [NSString stringWithFormat:
 @"%lu matches found", (unsigned long)[objects count]];
 }
 }
 */

@end
