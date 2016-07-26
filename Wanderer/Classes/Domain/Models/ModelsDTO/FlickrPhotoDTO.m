//
//  FlickrPhotoDTO.m
//  Wanderer
//
//  Created by Daniel on 25/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "FlickrPhotoDTO.h"

@implementation FlickrPhotoDTO

- (instancetype)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    
    self.FKPhotoID = dic[@"id"];
    self.FKPhotoURL = dic[@"photoURL"];
    self.FKPhotoThumbURL = dic[@"photoThumbURL"];
    self.FKPhotoTitle = dic[@"title"];
    self.FKPhotoOwnerID = dic[@"owner"];
    
    return self;
}

@end
