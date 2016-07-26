//
//  DetailViewController.h
//  Wanderer
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel+CoreDataProperties.h"
#import "FlickrPhotoDTO.h"

@interface DetailViewController : UIViewController
{
    __weak IBOutlet NSLayoutConstraint *_topContainerHeightConstraint;
    
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_subtitleLabel;
    __weak IBOutlet UILabel *_descriptionLabel;
    __weak IBOutlet UIButton *_addButton;
}

@property (nonatomic, strong)FlickrPhotoDTO *data;
@property (nonatomic, assign)BOOL dismissOnFavAddition;
@end
