//
//  ViewController.m
//  Placeholder
//
//  Created by qdaily on 2018/12/27.
//  Copyright © 2018 com.kuruiaosi. All rights reserved.
//

#import "ViewController.h"
#import "FFTableView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) IBOutlet FFTableView *tableView;

@property(nonatomic, strong) NSMutableArray *data;
@end

static NSString * const kReusedId = @"cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReusedId];
    
    UIView *tableviewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    [tableviewHeader addSubview:titleLab];
    titleLab.text = @"这是头部";
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(tableviewHeader);
    }];
    tableviewHeader.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = tableviewHeader;
    self.tableView.placeholderType = QDNPlaceholderTypeLoading;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reload:nil];
    });
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusedId];
    cell.textLabel.text = [NSString stringWithFormat:@"index %ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (IBAction)reload:(id)sender {
    
    
    if (self.data.count == 0) {
        
        int total = arc4random_uniform(50);
        for (int i = 0; i < total; i++) {
            [self.data addObject:@(i)];
        }
        self.tableView.placeholderType = QDNPlaceholderTypeDefault;
    }else{
        self.tableView.placeholderType = arc4random_uniform(2) == 0 ? QDNPlaceholderTypeEmpty : QDNPlaceholderTypeError;
        [self.data removeAllObjects];
    }
    [self.tableView reloadData];
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}
@end
