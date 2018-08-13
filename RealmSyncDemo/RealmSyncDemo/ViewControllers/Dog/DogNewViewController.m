//
//  DogNewViewController.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "DogNewViewController.h"
#import "Person.h"
#import "Dog.h"

@interface DogNewViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation DogNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    Dog *d = [[Dog alloc] init];
    d.name = _textField.text;
    d.created = [NSDate date];
    
    RLMRealm *realm = _person.realm;
    [realm beginWriteTransaction];
    [_person.dogs addObject:d];
    [realm commitWriteTransaction];
    [self.navigationController popViewControllerAnimated:YES];
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
