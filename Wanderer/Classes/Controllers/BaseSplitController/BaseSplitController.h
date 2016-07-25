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
#import "TableViewController.h"
#import "OnTapDelegate.h"

@interface BaseSplitController : UISplitViewController <UISplitViewControllerDelegate,OnTapDelegate>
{
    UIViewController *masterViewController;
    DetailViewController *detailViewController;
}
@end
