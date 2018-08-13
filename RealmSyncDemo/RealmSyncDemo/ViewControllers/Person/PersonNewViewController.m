//
//  PersonNewViewController.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "PersonNewViewController.h"
#import "Person.h"

@interface PersonNewViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation PersonNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    Person *p = [[Person alloc] init];
    p.name = _textField.text;
    p.created = [NSDate date];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:p];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
