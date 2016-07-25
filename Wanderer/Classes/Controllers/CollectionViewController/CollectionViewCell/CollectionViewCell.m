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

- (void)setData:(PhotoModel *)data
{
    _data = data;
    [self updateView];
}

- (void)updateView
{
    [_titleLabel setText:_data.photoTitle];
    [_subtitleLabel setText:_data.photoID];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_data.photoThumbURL]];
    [_addButton setTitle:self.data.isFavorite?@"-":@"+" forState:UIControlStateNormal];
}

- (IBAction)onAddButtonTUI:(id)sender
{
    if([_addButton.titleLabel.text isEqualToString:@"+"]){
        self.data.isFavorite = @(YES);
    }else{
        self.data.isFavorite = @(NO);
    }
    [[CoreDataManager sharedInstance] saveContextWithCompletion:^(BOOL boolean) {
        if(boolean){
            [self updateView];
        }
    }];
}
@end
