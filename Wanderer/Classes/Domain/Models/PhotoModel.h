//
//  PhotoModel.h
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoModel : NSManagedObject

- (instancetype)initWithDictionary:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END

#import "PhotoModel+CoreDataProperties.h"
