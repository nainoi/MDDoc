//
//  LoginViewController.h
//  mddoc
//
//  Created by Phitsanu Kaewtep on 2/20/15.
//  Copyright (c) 2015 GLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASTextField;
@class LoginViewController;

@protocol LoginViewDelegate <NSObject>

-(void)didLoginViewController:(LoginViewController*)logingView;

@end

@interface LoginViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

//cells
@property (strong, nonatomic) IBOutlet UITableViewCell *usernameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *passwordCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *doneCell;

//fields
@property (strong, nonatomic) IBOutlet ASTextField *passwordField;
@property (strong, nonatomic) IBOutlet ASTextField *usernameField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (assign, nonatomic) id<LoginViewDelegate>delegate;

- (IBAction)changeFieldBackground:(id)sender;
- (IBAction)letMeIn:(id)sender;

@end
