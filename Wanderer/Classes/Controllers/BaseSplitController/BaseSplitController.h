//
//  BaseSplitController.h
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewcontroller.h"
#import "DetailViewController.h"
#import "OnTapDelegate.h"

@interface BaseSplitController : UISplitViewController <UISplitViewControllerDelegate,OnTapDelegate>
{
    CollectionViewController *masterViewController;
    DetailViewController *detailViewController;
}
@end
