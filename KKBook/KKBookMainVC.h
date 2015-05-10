//
//  KKBookMainVC.h
//  KKBooK
//
//  Created by PromptNow Ltd. on 30/10/14.
//  Copyright (c) 2014 GLive. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    STORE = 0,
    LIBRARY = 1,
    SETTING = 2,
    USER = 3,
    ABOUT
    
}PageType;

@interface KKBookMainVC : BaseViewController

@property(strong, nonatomic) UIViewController *mainController;
@property(assign, nonatomic) PageType pageType;

@end
