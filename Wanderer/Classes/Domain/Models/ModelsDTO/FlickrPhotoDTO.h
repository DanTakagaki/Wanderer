//
//  FlickrPhotoDTO.h
//  Wanderer
//
//  Created by Daniel on 25/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhotoDTO : NSObject

@property (nonatomic, strong) NSString *FKPhotoID;
@property (nonatomic, strong) NSString *FKPhotoURL;
@property (nonatomic, strong) NSString *FKPhotoThumbURL;
@property (nonatomic, strong) NSString *FKPhotoTitle;
@property (nonatomic, strong) NSString *FKPhotoOwnerID;
@property (nonatomic, assign) BOOL FKPhotoIsFavorite;

- (instancetype)initWithDictionary:(NSDictionary*)dic;
@end
