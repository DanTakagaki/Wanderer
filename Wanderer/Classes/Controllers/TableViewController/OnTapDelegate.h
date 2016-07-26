//
//  OnTapDelegate.h
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrPhotoDTO.h"

@protocol OnTapDelegate <NSObject>
@optional
- (void)didPressCellWithData:(FlickrPhotoDTO*)data;

@end

