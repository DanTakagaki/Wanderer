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

- (void)setData:(PhotoModel *)data
{
    _data = data;
    [self updateView];
}

- (void)updateView
{
    [_titleLabel setText:_data.photoTitle];
    [_subtitleLabel setText:_data.photoID];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_data.photoURL]];
    [_descriptionLabel setText:_data.ownerID];
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
            
            if(_dismissOnFavAddition){
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}
@end
