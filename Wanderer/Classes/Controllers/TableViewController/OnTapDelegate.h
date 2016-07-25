//
//  OnTapDelegate.h
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoModel.h"

@protocol OnTapDelegate <NSObject>
@optional
- (void)didPressCellWithData:(PhotoModel*)data;

@end

