//
//  Service.h
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void (^VoidResultBlock_t)(void);
typedef void (^CompletionBlock_t)(NSArray *response, NSError *error);

@interface Service : NSObject

+ (instancetype)sharedInstance;

- (void)fetchFlickrInterestingPhotosWithCompletion:(CompletionBlock_t)error;
@end
