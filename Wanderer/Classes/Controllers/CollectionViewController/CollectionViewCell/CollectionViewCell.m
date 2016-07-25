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
    [_titleLabel setText:data.photoTitle];
    [_subtitleLabel setText:data.photoID];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:data.photoURL]];
}

@end
