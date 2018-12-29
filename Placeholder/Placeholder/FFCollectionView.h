//
//  FFCollectionView.h
//  Placeholder
//
//  Created by qdaily on 2018/12/29.
//  Copyright © 2018 com.kuruiaosi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FFCollectionView : UICollectionView

@property(nonatomic, weak) UIView *loadingPlaceholder;

@property(nonatomic, weak) UIView *emptyPlaceholder;

@property(nonatomic, weak) UIView *errorPlaceholder;

@property(nonatomic, assign) QDNPlaceholderType placeholderType;

@end

NS_ASSUME_NONNULL_END
