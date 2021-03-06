//
//  BaseSplitController.m
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "BaseSplitController.h"
#import "DetailViewController.h"

@implementation BaseSplitController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    masterViewController = [self.viewControllers[0] topViewController];
    if([masterViewController respondsToSelector:@selector(setDelegateController:)])
        [masterViewController performSelector:@selector(setDelegateController:) withObject: self];
    detailViewController = self.viewControllers[1];
}
#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    if ([secondaryViewController isKindOfClass:[DetailViewController class]]
        && [(DetailViewController*)secondaryViewController data] == nil) {
        
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
        
    } else {
        return NO;
    }
}

#pragma mark - CollectionViewControllerDelegate

- (void)didPressCellWithData:(FlickrPhotoDTO *)data
{
    [self showDetailViewController:detailViewController sender:self];
    [detailViewController setData:data];
    detailViewController.dismissOnFavAddition = [masterViewController isKindOfClass:[TableViewController class]];
}
@end
