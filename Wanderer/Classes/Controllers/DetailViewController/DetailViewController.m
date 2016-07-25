//
//  DetailViewController.m
//  Wanderer
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    //_topContainerHeightConstraint.constant = _imageView.superview.frame.size.height;
    
    [[BNRDynamicTypeManager sharedInstance] watchLabel:_titleLabel textStyle:UIFontTextStyleTitle1];
    [[BNRDynamicTypeManager sharedInstance] watchLabel:_subtitleLabel textStyle:UIFontTextStyleTitle2];
    [[BNRDynamicTypeManager sharedInstance] watchLabel:_descriptionLabel textStyle:UIFontTextStyleBody];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)setData:(PhotoModel *)data
{
    [_titleLabel setText:data.photoTitle];
    [_subtitleLabel setText:data.photoID];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:data.photoURL]];
    [_descriptionLabel setText:data.ownerID];
}

- (IBAction)onAddToFavButtonTUI:(id)sender
{
    
}
@end
