//
//  ContainerCellView.h
//  IndexTableWithSearchBar
//
//  Created by sri Divya on 12/10/16.
//  Copyright © 2016 MyCompanyName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerCellView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)setCollectionData:(NSArray *)collectionData;

@end
