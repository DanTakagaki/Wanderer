//
//  CollectionViewCell.m
//  Wanderer
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [[BNRDynamicTypeManager sharedInstance] watchLabel:_titleLabel textStyle:UIFontTextStyleTitle1];
    [[BNRDynamicTypeManager sharedInstance] watchLabel:_subtitleLabel textStyle:UIFontTextStyleTitle2];
    [[BNRDynamicTypeManager sharedInstance] watchButton:_addButton textStyle:UIFontTextStyleTitle2];
}

- (void)prepareForReuse
{
    [_titleLabel setText:@""];
    [_subtitleLabel setText:@""];
    [_imageView sd_cancelCurrentImageLoad];
    [_imageView setImage:nil];
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
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_data.FKPhotoThumbURL]];
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
        }];
    }
}
@end
