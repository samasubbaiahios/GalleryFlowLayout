//
//  PinterestLayout.h
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BWLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForPhotoAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfColumns:(UICollectionView *)column;
- (NSInteger)cellPadding:(UICollectionView *)padding;

@end

@interface BWLayout : UICollectionViewLayout

@property (nonatomic) id <BWLayoutDelegate> delegate;

@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) NSInteger cellPadding;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cache;
@property (nonatomic, assign) CGFloat contentHeight;


@end

