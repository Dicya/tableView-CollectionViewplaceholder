//
//  FFScrollView.h
//  Placeholder
//
//  Created by qdaily on 2018/12/27.
//  Copyright © 2018 com.kuruiaosi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, QDNPlaceholderType) {
    QDNPlaceholderTypeDefault,
    QDNPlaceholderTypeLoading,
    QDNPlaceholderTypeEmpty,
    QDNPlaceholderTypeError
};

NS_ASSUME_NONNULL_BEGIN

@interface FFTableView : UITableView

@property(nonatomic, weak) UIView *loadingPlaceholder;

@property(nonatomic, weak) UIView *emptyPlaceholder;

@property(nonatomic, weak) UIView *errorPlaceholder;

@property(nonatomic, assign) QDNPlaceholderType placeholderType;

@end

NS_ASSUME_NONNULL_END
