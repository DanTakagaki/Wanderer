//
//  PhotoModel+CoreDataProperties.h
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *photoID;
@property (nullable, nonatomic, retain) NSString *ownerID;
@property (nullable, nonatomic, retain) NSString *photoTitle;
@property (nullable, nonatomic, retain) NSString *photoURL;

@end

NS_ASSUME_NONNULL_END
