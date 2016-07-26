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
    [[BNRDynamicTypeManager sharedInstance] watchButton:_addButton textStyle:UIFontTextStyleTitle2];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)setData:(FlickrPhotoDTO *)data
{
    _data = data;
    [[CoreDataManager sharedInstance] existObjectWithDataDTO:_data withResult:^(BOOL boolean, NSError *error) {
        _data.FKPhotoIsFavorite = boolean;
    }];
    [self updateView];
}

- (void)updateView
{
    [_titleLabel setText:_data.FKPhotoTitle];
    [_subtitleLabel setText:_data.FKPhotoID];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_data.FKPhotoURL]];
    [_descriptionLabel setText:_data.FKPhotoOwnerID];
    [[CoreDataManager sharedInstance] existObjectWithDataDTO:_data withResult:^(BOOL boolean, NSError *error) {
        [_addButton setTitle:_data.FKPhotoIsFavorite?@"-":@"+" forState:UIControlStateNormal];
    }];
}

- (IBAction)onAddButtonTUI:(id)sender
{
    _addButton.enabled = NO;
    
    if(!_data.FKPhotoIsFavorite){
        [[CoreDataManager sharedInstance] insertNewObjectWithDataDTO:_data withResult:^(BOOL boolean, NSError *error) {
            if(!error){
                _data.FKPhotoIsFavorite = YES;
                [self updateView];
            }
            _addButton.enabled = YES;
        }];
        
    }else{
        [[CoreDataManager sharedInstance] deleteObjectWithID:_data.FKPhotoID withResult:^(BOOL boolean, NSError *error) {
            _addButton.enabled = YES;
            _data.FKPhotoIsFavorite = NO;
            [self updateView];
            
            if(_dismissOnFavAddition){
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

@end
