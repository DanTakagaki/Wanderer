//
//  PhotoModel+CoreDataProperties.m
//  Wanderer
//
//  Created by Daniel on 25/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PhotoModel+CoreDataProperties.h"

@implementation PhotoModel (CoreDataProperties)

@dynamic ownerID;
@dynamic photoID;
@dynamic photoTitle;
@dynamic photoURL;
@dynamic photoThumbURL;
@dynamic isFavorite;

@end
