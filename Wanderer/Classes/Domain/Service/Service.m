//
//  Service.m
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "Service.h"
#import "FlickrKit.h"
#import "PhotoModel+CoreDataProperties.h"

@implementation Service

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static Service *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [Service new];
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [[FlickrKit sharedFlickrKit] initializeWithAPIKey:@"a9c6911e31a4f2fea7870c4323cf2c24" sharedSecret:@"505b2dfdebc1a81b"];
    }
    return self;
}

- (void)fetchFlickrInterestingPhotosWithCompletion:(CompletionBlock_t)completionBlock
{
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
        if(error){
            NSLog(@"Error handling not Supported. Description: %@",error.localizedDescription);
        }else{
            // Note this is not the main thread!
            if (response) {
                NSMutableArray *mutArray = [NSMutableArray new];
                NSMutableDictionary *itDic;
                NSURL *url;
                for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                    itDic = [[NSMutableDictionary alloc]initWithDictionary:photoData];
                    url = [fk photoURLForSize:FKPhotoSizeSmall240 fromPhotoDictionary:photoData];
                    if(url.absoluteString)[itDic setObject:url.absoluteString forKey:@"photoThumbURL"];
                    
                    url = [fk photoURLForSize:FKPhotoSizeLarge1600 fromPhotoDictionary:photoData];
                    if(url.absoluteString)[itDic setObject:url.absoluteString forKey:@"photoURL"];

                    PhotoModel *model = [[PhotoModel alloc] initWithDictionary:itDic];
                    [mutArray addObject: model];
                }

                completionBlock([NSArray arrayWithArray:mutArray],error);
            }
        }
    }];
}

@end
