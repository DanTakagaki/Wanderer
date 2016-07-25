//
//  TableViewCell.h
//  Wanderer
//
//  Created by Daniel on 24/7/16.
//  Copyright © 2016 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel+CoreDataProperties.h"

@interface TableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_subtitleLabel;
    __weak IBOutlet UIImageView *_cellImageView;
    __weak IBOutlet UIButton *_addButton;
}

@property (nonatomic, strong)PhotoModel *data;

@end
