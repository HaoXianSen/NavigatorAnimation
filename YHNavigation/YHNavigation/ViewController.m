//
//  ViewController.m
//  YHNavigation
//
//  Created by HaoYuhong on 2018/6/21.
//  Copyright © 2018年 Harray. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, weak)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YHNagigation";
    [self setTableViewHeaderView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
}
- (void)initialized {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.rowHeight = 80.f;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)setTableViewHeaderView {
    if (!_tableView) {
        [self initialized];
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200)];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:bgView.bounds];
    bgImageView.image = [UIImage imageNamed:@"1"];
    [bgView addSubview:bgImageView];
    _tableView.tableHeaderView = bgImageView;
}

#pragma mark - UITableViewDataSource / Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"I am %ld row", indexPath.row];
    return cell;
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 100) {
        CGFloat offset = scrollView.contentOffset.y;
        CGFloat destinateOffset = 200;
        CGFloat v = offset / destinateOffset;
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        basicAnimation.fromValue = @(self.navigationController.navigationBar.layer.opacity);
        basicAnimation.toValue = @(v);
        basicAnimation.removedOnCompletion = false;
//        basicAnimation.additive = true;
        [self.navigationController.navigationBar.layer addAnimation:basicAnimation forKey:@"opacity"];
//        self.navigationController.navigationBar.alpha = 1;
    } else {
       self.navigationController.navigationBar.alpha = 0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
