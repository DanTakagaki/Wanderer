//
//  PhotoModel.m
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "PhotoModel.h"
#import "CoreDataManager.h"

@implementation PhotoModel

- (instancetype)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    
    self.photoID = dic[@"id"];
    self.photoURL = dic[@"url"];
    self.photoTitle = dic[@"title"];
    self.ownerID = dic[@"owner"];
    
    return self;
}

+ (void)addEntity
{
    PhotoModel *model = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PhotoModel class]) inManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext]];
    
    
}
@end
