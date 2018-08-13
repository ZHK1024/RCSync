//
//  PersonEditViewController.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "PersonEditViewController.h"
#import "DogNewViewController.h"
#import "DogEditViewController.h"
#import "Person.h"


@interface PersonEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RLMResults *dogs;

@end

@implementation PersonEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _textField.text = _person.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dogs = [_person.dogs objectsWhere:@"isDelete = 0"];
    [_tableView reloadData];
}

#pragma mark - Action

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    RLMRealm *realm = _person.realm;
    [realm transactionWithBlock:^{
        _person.name = _textField.text;
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)addAction:(UIBarButtonItem *)sender {
    DogNewViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DogNewViewController"];
    vc.person = _person;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Dog *d = _dogs[indexPath.row];
    cell.textLabel.text = d.name;
    return cell;
}

#pragma mark - UITableView delegate

// row select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DogEditViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DogEditViewController"];
    vc.dog = _dogs[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
