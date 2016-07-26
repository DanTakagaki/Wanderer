
//
//  CollectionViewController.m
//  Feeds
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "CollectionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoModel+CoreDataProperties.h"
#import "FlickrPhotoDTO.h"
#import "CollectionViewCell.h"

@implementation CollectionViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(startRefresh)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView  addSubview:_refreshControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadDataWithSpinner:YES];
}

- (void)loadDataWithSpinner:(BOOL)boolean
{
    if(boolean)[MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    
    [[Service sharedInstance]fetchFlickrInterestingPhotosWithCompletion:^(NSArray *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
            [_refreshControl endRefreshing];
        });
        
        if(!error){
            _dataArray = [NSArray arrayWithArray:response];
            [self.collectionView reloadData];
        }
    }];
}

- (void)startRefresh
{
    [self loadDataWithSpinner:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    // Configure Table View Cell
    FlickrPhotoDTO *model = (FlickrPhotoDTO*)_dataArray[indexPath.row];
    cell.data = model;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(_delegateController && [_delegateController respondsToSelector:@selector(didPressCellWithData:)]){
        FlickrPhotoDTO *model = (FlickrPhotoDTO*)_dataArray[indexPath.row];
        [_delegateController didPressCellWithData:model];
    }
}

@end
