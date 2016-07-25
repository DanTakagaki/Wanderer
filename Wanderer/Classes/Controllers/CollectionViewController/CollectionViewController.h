//
//  CollectionViewController.h
//  Feeds
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PhotoModel.h"
#import "OnTapDelegate.h"

@interface CollectionViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_fetchedResultsController;
    BOOL _shouldReloadCollectionView;
    NSBlockOperation *_blockOperation;
}

@property(nonatomic, assign) id<OnTapDelegate>delegateController;
@end
