//
//  UserViewController.h
//  mddoc
//
//  Created by Phitsanu Kaewtep on 2/24/15.
//  Copyright (c) 2015 GLive. All rights reserved.
//

#import "BaseViewController.h"

@class UserViewController;

@protocol UserViewDelegate <NSObject>

-(void)didLogout:(UserViewController*)viewController;
-(void)didCloseView:(UserViewController*)viewController;

@end

@interface UserViewController : BaseViewController

@property (assign, nonatomic) id<UserViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *fnameLb;
@property (weak, nonatomic) IBOutlet UILabel *lnameLb;
@property (weak, nonatomic) IBOutlet UILabel *emailLb;
@property (weak, nonatomic) IBOutlet UILabel *bdateLb;

@end
