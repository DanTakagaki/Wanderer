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

+ (instancetype)insertNewObjectWithDataDTO:(FlickrPhotoDTO*)dataDTO
{
    PhotoModel *model = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PhotoModel class]) inManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext]];
    
    model.photoID = dataDTO.FKPhotoID;
    model.photoURL = dataDTO.FKPhotoURL;
    model.photoThumbURL = dataDTO.FKPhotoThumbURL;
    model.photoTitle = dataDTO.FKPhotoTitle;
    model.ownerID = dataDTO.FKPhotoOwnerID;
    
    return model;
}

- (FlickrPhotoDTO*)objectToDataDTO
{
    FlickrPhotoDTO *model = [FlickrPhotoDTO new];
    
    model.FKPhotoID = self.photoID;
    model.FKPhotoURL = self.photoURL;
    model.FKPhotoThumbURL = self.photoThumbURL;
    model.FKPhotoTitle = self.photoTitle;
    model.FKPhotoOwnerID = self.ownerID;
    
    return model;
}
@end
