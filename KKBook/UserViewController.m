//
//  UserViewController.m
//  mddoc
//
//  Created by Phitsanu Kaewtep on 2/24/15.
//  Copyright (c) 2015 GLive. All rights reserved.
//

#import "UserViewController.h"
#import "BaseNavigationController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addNavigationItem];
    [self setTextValue];
}

-(void)setTextValue{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];


    _fnameLb.text = [NSString stringWithFormat:@"%@ %@",[userDefault stringForKey:@"fname"], [userDefault stringForKey:@"lname"]];
    _emailLb.text = [userDefault stringForKey:@"email"];
    _bdateLb.text = [userDefault stringForKey:@"bdate"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNavigationItem{
    UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    super.navigationItem.rightBarButtonItem = logoutBtn;
    
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    super.navigationItem.leftBarButtonItem = closeBtn;
    
    [self setNavigationBar];
    //((BaseNavigationController*)self.navigationController).navigationBar.barTintColor = [UIColor KKBookLightPurpleColor];
}

-(void)closeView{
    [self dismissViewControllerAnimated:YES completion:^(){
        if ([[self delegate] respondsToSelector:@selector(didCloseView:)]) {
            [[self delegate] didCloseView:self];
        }
    }];
}

-(void)logout{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"KKBook" message:@"Do you want to logout from device?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    [alertView show];
   
    
}

#pragma mark - UIAlert delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([[self delegate] respondsToSelector:@selector(didLogout:)]) {
            [[self delegate] didLogout:self];
            [self closeView];
        }
    }
}


@end
