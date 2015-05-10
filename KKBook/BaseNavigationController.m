//
//  CRNavigationController.m
//  CRNavigationControllerExample
//
//  Created by Corey Roberts on 9/24/13.
//  Copyright (c) 2013 SpacePyro Inc. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseNavigationBar.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)init {
    self = [super initWithNavigationBarClass:[BaseNavigationBar class] toolbarClass:nil];
    if(self) {
        // Custom initialization here, if needed.
        
        // To override the opacity of CRNavigationBar's barTintColor, set this value to YES.
        ((BaseNavigationBar *)self.navigationBar).overrideOpacity = NO;
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithNavigationBarClass:[BaseNavigationBar class] toolbarClass:nil];
    if(self) {
        self.viewControllers = @[rootViewController];
        
        // To override the opacity of CRNavigationBar's barTintColor, set this value to YES.
        ((BaseNavigationBar *)self.navigationBar).overrideOpacity = NO;
        //((BaseNavigationController*)self.navigationController).navigationBar.barTintColor = [UIColor colorWithRed:3/255.0 green:166/255.0 blue:130/255.0 alpha:1.0];
        [self setGreenNavigationBar];
    }
    
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)setGreenNavigationBar{
    ((BaseNavigationController*)self.navigationController).navigationBar.barTintColor = [UIColor KKBookLightPurpleColor];
}
@end
