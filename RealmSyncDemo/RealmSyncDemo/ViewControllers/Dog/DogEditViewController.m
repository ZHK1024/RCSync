//
//  DogEditViewController.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "DogEditViewController.h"
#import "DishNewViewController.h"
#import "Dog.h"
#import "Dish.h"

@interface DogEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RLMResults *dishes;

@end

@implementation DogEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.text = _dog.name;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData {
    self.dishes = [_dog.dishes objectsWhere:@"isDelete = 0"];
    [_tableView reloadData];
}

#pragma mark - Action

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    RLMRealm *realm = _dog.realm;
    [realm beginWriteTransaction];
    _dog.name = _textField.text;
    [realm commitWriteTransaction];
}

- (IBAction)addAction:(UIBarButtonItem *)sender {
    Dish *d = [[Dish alloc] init];
    d.index = (NSInteger)CFAbsoluteTimeGetCurrent();
    d.created = [NSDate date];
    
    RLMRealm *realm = _dog.realm;
    [realm beginWriteTransaction];
    [_dog.dishes addObject:d];
    [realm commitWriteTransaction];
    
    [self loadData];
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dishes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Dish *d = _dishes[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld Dish", d.index];
    return cell;
}

#pragma mark - UITableView delegate

// row select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// row heighr
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

// header footer height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

// view for header footer
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

@end
