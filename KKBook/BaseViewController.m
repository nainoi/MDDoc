//
//  BaseViewController.m
//  KKBooK
//
//  Created by PromptNow on 10/29/2557 BE.
//  Copyright (c) 2557 GLive. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "BaseNavigationBar.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark - navigation bar

-(void)hiddenBackTitle{
    ((UINavigationItem*)self.navigationController.navigationBar.items[0]).title = @"";
}

- (void)addBackNavigation{
    ((BaseNavigationController*)self.navigationController).navigationItem.backBarButtonItem.title = @"";
    //NSLog(@"bact title %@",((BaseNavigationController*)self.navigationController).navigationItem.leftBarButtonItem);
}

-(void)addCloseBarButtonItem{
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(dismissNavigationController)];
    self.navigationItem.leftBarButtonItem = closeButton;
}

- (void)setNavigationBar{
    ((BaseNavigationController*)self.navigationController).navigationBar.barTintColor = [UIColor KKBookLightPurpleColor];
}

-(void)dismissNavigationController{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - progress

-(void)showProgressLoading{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Loading...";
    
    [HUD show:YES];
}
-(void)showProgress{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    
    [HUD show:YES];
}

-(void)dismissProgress{
    [HUD hide:YES];
}

#pragma mark - alertview

+(void)showAlertWithMessage:(NSString*)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"KKBook" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

+(void)showAlertNotConnectInternet{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"KKBook" message:@"ขออภัยค่ะ โทรศัพท์ของท่านไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้ในขณะนี้ กรุณาตรวจสอบสัญญาณอินเทอร์เน็ตและลองใหม่อีกครั้ง" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
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
