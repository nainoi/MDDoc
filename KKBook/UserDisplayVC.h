//
//  UserDisplayVC.h
//  mddoc
//
//  Created by GLIVE on 3/14/2558 BE.
//  Copyright (c) 2558 GLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDisplayVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *emailLb;

- (IBAction)logoutBtn:(id)sender;

@end
