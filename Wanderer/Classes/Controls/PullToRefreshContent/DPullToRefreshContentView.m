//
//  CollectionViewController.h
//  Feeds
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "DPullToRefreshContentView.h"

@implementation DPullToRefreshContentView

- (void)setState:(SSPullToRefreshViewState)state withPullToRefreshView:(SSPullToRefreshView *)view {
    switch (state) {
        case SSPullToRefreshViewStateReady: {
            self.statusLabel.text = NSLocalizedString(@"Release To Refresh", nil);
            [self.activityIndicatorView startAnimating];
            self.activityIndicatorView.alpha = 0.0f;
            break;
        }
            
        case SSPullToRefreshViewStateNormal: {
            self.statusLabel.text = NSLocalizedString(@"Pull Down To Refresh", nil);
            self.statusLabel.alpha = 1.0f;
            [self.activityIndicatorView stopAnimating];
            self.activityIndicatorView.alpha = 0.0f;
            break;
        }
            
        case SSPullToRefreshViewStateLoading: {
            self.statusLabel.alpha = 0.0f;
            [self.activityIndicatorView startAnimating];
            self.activityIndicatorView.alpha = 1.0f;
            break;
        }
            
        case SSPullToRefreshViewStateClosing: {
            self.statusLabel.text = nil;
            self.activityIndicatorView.alpha = 0.0f;
            break;
        }
    }
}


@end
