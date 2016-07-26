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
    [[BNRDynamicTypeManager sharedInstance] watchButton:_addButton textStyle:UIFontTextStyleTitle2];
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
    _data = data;
    [self updateView];
}

- (void)updateView
{
    [_titleLabel setText:_data.photoTitle];
    [_subtitleLabel setText:_data.photoID];
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:_data.photoThumbURL]];
    [_addButton setTitle:@"-" forState:UIControlStateNormal];
}

- (IBAction)onAddButtonTUI:(id)sender
{
    _addButton.enabled = NO;
    
    [[CoreDataManager sharedInstance] deleteObjectWithID:_data.photoID withResult:^(BOOL boolean, NSError *error) {
        _addButton.enabled = YES;
    }];
}

@end
