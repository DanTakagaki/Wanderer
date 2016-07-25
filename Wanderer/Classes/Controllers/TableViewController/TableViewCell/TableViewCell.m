//
//  TableViewCell.m
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "TableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TableViewCell

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
    [_cellImageView sd_cancelCurrentImageLoad];
    [_cellImageView setImage:nil];
}

- (void)setData:(PhotoModel *)data
{
    [_titleLabel setText:data.photoTitle];
    [_subtitleLabel setText:data.photoID];
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:data.photoURL]];
}

@end
