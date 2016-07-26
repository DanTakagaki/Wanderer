
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
#import "DPullToRefreshContentView.h"

@interface CollectionViewController()

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@end

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
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataWithSpinner:YES];
    
    _pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.collectionView delegate:self];
    _pullToRefreshView.contentView = [[DPullToRefreshContentView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
}

- (void)loadDataWithSpinner:(BOOL)boolean
{
    if(boolean)[MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    
    [[Service sharedInstance]fetchFlickrInterestingPhotosWithCompletion:^(NSArray *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
            [_pullToRefreshView finishLoading];
            if(!error){
                _dataArray = [NSMutableArray arrayWithArray:response];
                [self.collectionView reloadData];
            }
        });
    }];
}

#pragma mark -  SSPullToRefreshViewDelegate

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view
{
    [self loadDataWithSpinner:NO];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger rowCount;
    if(_isFiltered)
        rowCount = _filteredTableData.count;
    else
        rowCount = _dataArray.count;
    
    return rowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];

    FlickrPhotoDTO* model;
    if(_isFiltered)
        model = (FlickrPhotoDTO*)_filteredTableData[indexPath.row];
    else
        model = (FlickrPhotoDTO*)_dataArray[indexPath.row];
    
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

#pragma mark - UISearchBarDelegate

//user finished editing the search text
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        _isFiltered = NO;
    }
    else
    {
        _isFiltered = YES;
        _filteredTableData = [[NSMutableArray alloc] init];
        
        for (FlickrPhotoDTO* modelDTO in _dataArray)
        {
            NSRange titleRange = [modelDTO.FKPhotoTitle rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [modelDTO.FKPhotoOwnerID rangeOfString:text options:NSCaseInsensitiveSearch];
            if(titleRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                [_filteredTableData addObject:modelDTO];
            }
        }
    }
    
    [self.collectionView reloadData];
}
@end
