//
//  DishNewViewController.m
//  RealmSyncDemo
//
//  Created by ZHK on 2018/8/13.
//  Copyright © 2018年 ZHK. All rights reserved.
//

#import "DishNewViewController.h"
#import "Dog.h"
#import "Dish.h"

@interface DishNewViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation DishNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(UIBarButtonItem *)sender {
    Dish *d = [[Dish alloc] init];
    d.index = (NSInteger)CFAbsoluteTimeGetCurrent();
    d.created = [NSDate date];
    
    RLMRealm *realm = _dog.realm;
    [realm beginWriteTransaction];
    [_dog.dishes addObject:d];
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
