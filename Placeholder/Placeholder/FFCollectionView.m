//
//  FFCollectionView.m
//  Placeholder
//
//  Created by qdaily on 2018/12/29.
//  Copyright © 2018 com.kuruiaosi. All rights reserved.
//

#import "FFCollectionView.h"
#import <Masonry/Masonry.h>
@implementation FFCollectionView

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initPlaceholder];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initPlaceholder];
    }
    return self;
}

- (void)initPlaceholder{
    UIView *empty = [[UIView alloc] initWithFrame:CGRectZero];
    empty.backgroundColor = [UIColor purpleColor];
    UILabel *emptyLab = [[UILabel alloc] initWithFrame:CGRectZero];
    emptyLab.text = @"没有数据返回";
    emptyLab.textAlignment = NSTextAlignmentCenter;
    [empty addSubview:emptyLab];
    [emptyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(empty);
    }];
    [self addSubview:empty];
    self.emptyPlaceholder = empty;
    
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectZero];
    loadingView.backgroundColor = [UIColor greenColor];
    UILabel *loadingLab = [[UILabel alloc] initWithFrame:CGRectZero];
    loadingLab.text = @"Loading....";
    loadingLab.textAlignment = NSTextAlignmentCenter;
    [loadingView addSubview:loadingLab];
    [loadingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(loadingView);
    }];
    
    [self addSubview:loadingView];
    self.loadingPlaceholder = loadingView;
    
    UIView *errorView = [[UIView alloc] initWithFrame:CGRectZero];
    loadingView.backgroundColor = [UIColor blueColor];
    UILabel *errorLab = [[UILabel alloc] initWithFrame:CGRectZero];
    errorLab.text = @"网络出错了";
    errorLab.textAlignment = NSTextAlignmentCenter;
    [errorView addSubview:errorLab];
    [errorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(errorView);
    }];
    [self addSubview:errorView];
    self.errorPlaceholder = errorView;
}


- (void)reloadData{
    [super reloadData];
    [self showPlaceholderIfNeed];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIEdgeInsets adjustedContentInset;
    if (@available(iOS 11.0, *)) {
        adjustedContentInset = self.adjustedContentInset;
    } else {
        adjustedContentInset = self.contentInset;
    }
    
    CGFloat x = 0;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat y = 0;
    CGFloat height = CGRectGetHeight(self.bounds) - adjustedContentInset.top;
    CGRect frame = CGRectMake(x, y, width, height);
    
    self.loadingPlaceholder.frame = frame;
    self.emptyPlaceholder.frame = frame;
    self.errorPlaceholder.frame = frame;
}


- (void)showPlaceholderIfNeed{
    
    // reset all place holder
    self.loadingPlaceholder.hidden = YES;
    self.emptyPlaceholder.hidden = YES;
    self.errorPlaceholder.hidden = YES;
    
    
    if ([self hasData]) return;
    
    // show view if need
    UIView *willShowView;
    switch (self.placeholderType) {
        case QDNPlaceholderTypeEmpty:
            willShowView = self.emptyPlaceholder;
            break;
            
        case QDNPlaceholderTypeLoading:
            willShowView = self.loadingPlaceholder;
            break;
            
        case QDNPlaceholderTypeError:
            willShowView = self.errorPlaceholder;
            break;
        default:
            break;
    }
    [self bringSubviewToFront:willShowView];
    willShowView.hidden = NO;
}


- (BOOL)hasData{
    NSInteger sectionCount = [self numberOfSections];
    if (sectionCount <= 0) return NO;
    
    for (int i = 0; i < sectionCount; i++) {
        if ([self numberOfItemsInSection:i] > 0) {
            return YES;
        }
    }
    return NO;
}
@end
