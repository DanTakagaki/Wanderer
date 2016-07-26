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
#import "SSPullToRefresh.h"

@interface CollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate,SSPullToRefreshViewDelegate>
{
    BOOL _isFiltered;
    BOOL _orderAlphabetically;
    
    SSPullToRefreshView *_pullToRefreshView;
}

@property(nonatomic, assign) id<OnTapDelegate>delegateController;
@end
