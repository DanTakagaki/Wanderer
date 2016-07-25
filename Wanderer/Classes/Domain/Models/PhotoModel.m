//
//  PhotoModel.m
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

- (instancetype)initWithDictionary:(NSDictionary*)dic
{
    self = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PhotoModel class]) inManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext]];
    
    self.photoID = dic[@"id"];
    self.photoURL = dic[@"photoURL"];
    self.photoThumbURL = dic[@"photoThumbURL"];
    self.photoTitle = dic[@"title"];
    self.ownerID = dic[@"owner"];
    
    return self;
}

@end
