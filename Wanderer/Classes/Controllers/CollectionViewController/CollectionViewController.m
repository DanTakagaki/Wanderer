
//
//  CollectionViewController.m
//  Feeds
//
//  Created by Daniel on 23/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoModel+CoreDataProperties.h"

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
    
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PhotoModel class])];
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"photoTitle" ascending:YES]]];
    
    // Initialize Fetched Results Controller
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext: [[CoreDataManager sharedInstance] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    // Configure Fetched Results Controller
    [_fetchedResultsController setDelegate:self];
    
    // Perform Fetch
    NSError *error = nil;
    [_fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData
{
    [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    
    [[Service sharedInstance]fetchFlickrInterestingPhotosWithCompletion:^(NSArray *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.collectionView animated:YES];
        });
        
        if(!error){
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PhotoModel class])];
            NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
            
            NSError *error = nil;
            [[[CoreDataManager sharedInstance]persistentStoreCoordinator] executeRequest:delete withContext:[[CoreDataManager sharedInstance]managedObjectContext] error:&error];
            
            if (error) {
                NSLog(@"%@, %@", error, error.localizedDescription);
            }else{
                [[CoreDataManager sharedInstance] saveContextWithCompletion:^(BOOL boolean) {
                    if(boolean){
                        NSError *error = nil;
                        [_fetchedResultsController performFetch:&error];
                    }
                }];
            }
        }
    }];
}

- (void)configureCell:(CollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Fetch Record
    PhotoModel *model = (PhotoModel*)[_fetchedResultsController objectAtIndexPath:indexPath];
    cell.data = model;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *sections = [_fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    // Configure Table View Cell
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[_fetchedResultsController sections] count];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(_delegateController && [_delegateController respondsToSelector:@selector(didPressCellWithData:)]){
        PhotoModel *model = (PhotoModel*)[_fetchedResultsController objectAtIndexPath:indexPath];
        [_delegateController didPressCellWithData:model];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    //[self.collectionView beginUpdates];
    
    _shouldReloadCollectionView = NO;
    _blockOperation = [[NSBlockOperation alloc] init];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //[self.collectionView endUpdates];
    
    // Checks if we should reload the collection view to fix a bug @ http://openradar.appspot.com/12954582
    if (_shouldReloadCollectionView) {
        [self.collectionView reloadData];
    } else {
        [self.collectionView performBatchUpdates:^{
            [_blockOperation start];
        } completion:nil];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    __weak UICollectionView *collectionView = self.collectionView;
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            if ([self.collectionView numberOfSections] > 0) {
                if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
                    _shouldReloadCollectionView = YES;
                } else {
                    [_blockOperation addExecutionBlock:^{
                        [collectionView insertItemsAtIndexPaths:@[newIndexPath]];
                    }];
                }
            } else {
                _shouldReloadCollectionView = YES;
            }
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
                _shouldReloadCollectionView = YES;
            } else {
                [_blockOperation addExecutionBlock:^{
                    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
                }];
            }
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            [_blockOperation addExecutionBlock:^{
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeMove: {
            [_blockOperation addExecutionBlock:^{
                [collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    __weak UICollectionView *collectionView = self.collectionView;
    switch(type) {
        case NSFetchedResultsChangeInsert:{
             [_blockOperation addExecutionBlock:^{
                 [collectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
             }];
            break;}
        case NSFetchedResultsChangeDelete:{
            [_blockOperation addExecutionBlock:^{
                [collectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;}
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:{
            [_blockOperation addExecutionBlock:^{
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;}
    }
}

@end
