//
//  FFCollectionViewController.m
//  Placeholder
//
//  Created by qdaily on 2018/12/29.
//  Copyright © 2018 com.kuruiaosi. All rights reserved.
//

#import "FFCollectionViewController.h"
#import "FFCollectionView.h"

@interface FFCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet FFCollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *data;
@end

static NSString * const kCellReusedId = @"cell";
static NSString * const kHeaderReusedId = @"header";
static NSString * const kFooterReusedId = @"footer";
@implementation FFCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 44);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 60);
    layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 20);
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellReusedId];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReusedId];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterReusedId];
    self.collectionView.placeholderType = QDNPlaceholderTypeLoading;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reload:nil];
    });
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.data.count == 0) {
        return 0;
    }
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReusedId forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.f green:arc4random_uniform(256)/255.f blue:arc4random_uniform(256)/255.f alpha:1.0];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   
    UICollectionReusableView *cell;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReusedId forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterReusedId forIndexPath:indexPath];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    return cell;
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (IBAction)reload:(id)sender {
    if (self.data.count == 0) {
        
        int total = arc4random_uniform(10);
        for (int i = 0; i < total; i++) {
            [self.data addObject:@(i)];
        }
        self.collectionView.placeholderType = QDNPlaceholderTypeDefault;
    }else{
        self.collectionView.placeholderType = arc4random_uniform(2) == 0 ? QDNPlaceholderTypeEmpty : QDNPlaceholderTypeError;
        [self.data removeAllObjects];
    }
    [self.collectionView reloadData];
}

@end
