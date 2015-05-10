//
//  KKBookMainVC.m
//  KKBooK
//
//  Created by PromptNow Ltd. on 30/10/14.
//  Copyright (c) 2014 GLive. All rights reserved.
//

#import "KKBookMainVC.h"
#import "KKBookLeftSidebar.h"
#import "KKBookLibraryVC.h"
#import "KKBookStoreMain.h"
#import "KKBookStoreDetailVC.h"
#import "ReaderViewController.h"
#import "KKBookStoreListVC.h"
#import "KKBookSettingVC.h"
#import "InteractiveReader.h"
#import "BakerViewController.h"
#import "LoginViewController.h"
#import "UserViewController.h"
#import "ASTextField.h"
#import "BaseNavigationController.h"

#import "InternetChecking.h"
#import "DataManager.h"
#import "BookEntity.h"
#import "FileHelper.h"
#import "BakerBook.h"
#import "Utils.h"

@interface KKBookMainVC ()<KKBookLeftSidebarDelegate, KKBookStoreMainDelegate, ReaderViewControllerDelegate, KKBookLibraryDelegate, KKBookStoreListDelegate, LoginViewDelegate, UserViewDelegate>{
    KKBookStoreMain *storeVC;
    KKBookLibraryVC *libraryVC;
    KKBookSettingVC *settingVC;
    UserViewController *userVC;
    ReaderViewController *readerViewController;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) KKBookLeftSidebar *leftSideBar;

@end

@implementation KKBookMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //init
    
    [self setNavigationBar];
    [self setMainMenuItem];
    [self addNavigationItem];
    [self initMainViewController];
    [self initView];
    [self toggleViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMainViewController{
    self.mainController = [[UIViewController alloc] init];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    frame.size.height = CGRectGetHeight(frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame);
    _mainController.view.frame = frame;
    //_mainController.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainController.view];
    
    libraryVC = [[KKBookLibraryVC alloc] init];
    libraryVC.delegate = self;
    libraryVC.view.frame = [self frameForViewController];
    
    if ([InternetChecking isConnectedToInternet]) {
        storeVC = [[KKBookStoreMain alloc] init];
        storeVC.delegate = self;
        storeVC.view.frame = [self frameForViewController];

        self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
        _pageType = STORE;
        self.title = @"mddoc";
        [_mainController.view addSubview:storeVC.view];
        [_mainController viewWillAppear:NO];
    }else{
        self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
        _pageType = LIBRARY;
        self.title = @"my doc";
        [_mainController.view addSubview:libraryVC.view];
    }
    
    [self addNavigationItem];
    
}

-(void)initView{
    settingVC = [[KKBookSettingVC alloc] init];
    userVC = [[UserViewController alloc] init];
}

-(CGRect)frameForViewController{
    CGRect frame = _mainController.view.frame;
    frame.origin.y = 0;
    return frame;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (![userDefault boolForKey:IS_LOGIN]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        [self presentViewController:loginVC animated:YES completion:^(){
            
        }];
    }
}

#pragma mark - orientation

-(BOOL)shouldAutorotate{
    return NO;
}

#pragma mark - top view

-(void)toggleViewController{
//    CGRect frame = _mainController.view.bounds;
//    frame.origin.y = 0;
    switch (_pageType) {
        case STORE:
            if (_mainController.view.superview == storeVC.view) {
                return;
            }else{
                [libraryVC.view removeFromSuperview];
                [settingVC.view removeFromSuperview];
                [userVC.view removeFromSuperview];
            }
            storeVC.view.frame = [self frameForViewController];
            self.title = @"mddoc";
            [_mainController.view addSubview:storeVC.view];
            break;
            
        case LIBRARY:
            if (_mainController.view.superview == libraryVC.view) {
                return;
            }else{
                [storeVC.view removeFromSuperview];
                [settingVC.view removeFromSuperview];
                [userVC.view removeFromSuperview];
            }
            libraryVC.view.frame = [self frameForViewController];
            self.title = @"my doc";
            [_mainController.view addSubview:libraryVC.view];
            break;
            
        case ABOUT:
            if (_mainController.view.superview == libraryVC.view) {
                return;
            }else{
                [storeVC.view removeFromSuperview];
                [libraryVC.view removeFromSuperview];
                [settingVC.view removeFromSuperview];
            }
            libraryVC.view.frame = [self frameForViewController];
            self.title = @"about";
            [_mainController.view addSubview:libraryVC.view];
            break;
            
        case SETTING:
            if (_mainController.view.superview == settingVC.view) {
                return;
            }else{
                [storeVC.view removeFromSuperview];
                [libraryVC.view removeFromSuperview];
                [userVC.view removeFromSuperview];
            }
            settingVC.view.frame = [self frameForViewController];
            self.title = @"setting";
            [_mainController.view addSubview:settingVC.view];
            break;
        case USER:
            if (_mainController.view.superview == userVC.view) {
                return;
            }else{
                [storeVC.view removeFromSuperview];
                [libraryVC.view removeFromSuperview];
                [settingVC.view removeFromSuperview];
            }
            userVC.view.frame = [self frameForViewController];
            self.title = @"profile";
            [_mainController.view addSubview:userVC.view];
            break;
            
        default:
            break;
    }
}

#pragma mark - left menu

-(void)setMainMenuItem{
    UIImage *mainMenuImage = [UIImage imageNamed:@"ic_menu.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.reversesTitleShadowWhenHighlighted = YES;
    [button setImage:mainMenuImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, 40.0, 30.0);
    [button addTarget:self action:@selector(tapLeftMainMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *mainMenu = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = mainMenu;
}

#pragma mark - navigation item

-(void)addNavigationItem{
    if (_pageType == STORE) {
        UIBarButtonItem *allBtn = [[UIBarButtonItem alloc] initWithTitle:@"ALL" style:UIBarButtonItemStylePlain target:self action:@selector(showAllBook)];
        self.navigationItem.rightBarButtonItem = allBtn;
    }else if (_pageType == LIBRARY){
        UIBarButtonItem *allBtn = [[UIBarButtonItem alloc] initWithTitle:@"EDIT" style:UIBarButtonItemStylePlain target:self action:@selector(showDeleteBook)];
        self.navigationItem.rightBarButtonItem = allBtn;
    }else if (_pageType == USER){
        UIBarButtonItem *allBtn = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(didLogout:)];
        self.navigationItem.rightBarButtonItem = allBtn;
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
    
}

-(KKBookLeftSidebar *)leftSideBar{
    if (!_leftSideBar) {
        NSArray *images = @[
                            [UIImage imageNamed:@"globe"],
                            [UIImage imageNamed:@"shelf"],
                            [UIImage imageNamed:@"gear"],
                            [UIImage imageNamed:@"profile"]
                            ];
        NSArray *titles = @[
                            @"MD Doc",
                            @"My Doc",
                            @"Setting",
                            @"User"
                            ];
        NSArray *colors = @[
                            [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                            [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                            [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                            [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1]
                            ];
        
        KKBookLeftSidebar *callout = [[KKBookLeftSidebar alloc] initWithImages:images titles:titles selectedIndices:self.optionIndices borderColors:colors];
        callout.isSingleSelect = YES;
        self.leftSideBar = callout;
        callout.delegate = self;
        
    }
    return _leftSideBar;

}

-(void)tapLeftMainMenu{
           //    callout.showFromRight = YES;
    [self.leftSideBar show];

}

-(void)gotoLibrary{
    [self.leftSideBar didTapItemAtIndex:1];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)showUserDetail{
    UserViewController *userDetailVC = [[UserViewController alloc] init];
    userDetailVC.delegate = self;
    BaseNavigationController *naviVC = [[BaseNavigationController alloc] initWithRootViewController:userDetailVC];
    naviVC.modalPresentationStyle = UIModalPresentationFormSheet;

    [self presentViewController:naviVC animated:YES completion:^{
        
    }];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(KKBookLeftSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    if (index == 0) {
        if ([InternetChecking isConnectedToInternet]) {
            _pageType = STORE;
        }else{
            [BaseViewController showAlertNotConnectInternet];
        }
    }else if (index == 1){
        _pageType = LIBRARY;
    }
    else if (index == 2) {
        _pageType = SETTING;
    }else if(index == 3){
        //_pageType = USER;
        [self showUserDetail];
        //return;
    }
    [self toggleViewController];
    [self addNavigationItem];
    [sidebar dismissAnimated:YES completion:nil];
}

- (void)sidebar:(KKBookLeftSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    //if (itemEnabled) {
    
        [self.optionIndices addIndex:index];
    //}
}

#pragma mark - KKBookStore delegate

-(void)bookStoreMain:(KKBookStoreMain *)storeMain didBook:(BookModel *)book{
    KKBookStoreDetailVC *bookDetailVC = [[KKBookStoreDetailVC alloc] initWithBook:book];
    bookDetailVC.didDownload = ^(BookModel *bookModel){
        if ([[DataManager shareInstance] selectBookFromBookID:bookModel.bookID]) {
            [self.leftSideBar didTapItemAtIndex:1];
        }else{
            [[DataManager shareInstance] insertBookWithBookModel:bookModel onComplete:^(NSArray *books){
                [self.leftSideBar didTapItemAtIndex:1];
                
            }];
        }
    };
    
    //open
    bookDetailVC.didOpen = ^(BookModel *bookModel){
        BookEntity *bookEntity = [[DataManager shareInstance] selectBookFromBookID:bookModel.bookID];
        [self.leftSideBar didTapItemAtIndex:1];
         
        if ([bookEntity.fileTypeName isEqualToString:@"PDF"]) {
            [self pdfReaderWithBookEntity:bookEntity];
        }else{
            [self readerInteractive:bookEntity];
        }

    };
    [self.navigationController pushViewController:bookDetailVC animated:YES];
}

-(void)bookStoreMain:(KKBookStoreMain *)storeMain didListBook:(BookModel *)book{
    KKBookStoreListVC *listVC = [[KKBookStoreListVC alloc] init];
    listVC.delegate = self;
    [self.navigationController pushViewController:listVC animated:YES];

}

-(void)showAllBook{
    //KKBookStoreVC *bookListVC = [[KKBookStoreVC alloc] init];
    KKBookStoreListVC *listVC = [[KKBookStoreListVC alloc] init];
    listVC.delegate = self;
    [self.navigationController pushViewController:listVC animated:YES];
}

-(void)showDeleteBook{
    libraryVC.isDelete = !libraryVC.isDelete;
    if(libraryVC.isDelete){
        self.navigationItem.rightBarButtonItem.title = @"Done";
    }else{
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    }
}

#pragma mark - KKBookStoreList delegate

-(void)storeListSelectBook:(BookModel *)bookModel{
    KKBookStoreDetailVC *bookDetailVC = [[KKBookStoreDetailVC alloc] initWithBook:bookModel];
    bookDetailVC.didDownload = ^(BookModel *bookModel){
        if ([[DataManager shareInstance] selectBookFromBookID:bookModel.bookID]) {
            [self gotoLibrary];
        }else{
            [[DataManager shareInstance] insertBookWithBookModel:bookModel onComplete:^(NSArray *books){
                [self gotoLibrary];
                
            }];
        }
    };
    [self.navigationController pushViewController:bookDetailVC animated:YES];

}

#pragma mark - KKBookLibrary delegate

-(void)didSelectBook:(KKBookLibraryVC *)bookLibrary withBookEntity:(BookEntity *)bookEntity{
    if ([bookEntity.fileTypeName isEqualToString:@"PDF"]) {
        [self pdfReaderWithBookEntity:bookEntity];
    }else{
        [self readerInteractive:bookEntity];
    }
    
}

#pragma mark - PDF Reader

-(void)pdfReaderWithBookEntity:(BookEntity*)bookEntity{
    NSString *path = [[FileHelper booksPath]stringByAppendingPathComponent:bookEntity.folder];
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    NSString *filePath = nil;
    
    NSArray *directoryContent = [[NSFileManager  defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    
    for (NSString *file in directoryContent)
    {
        // NSString *file = [directoryContent objectAtIndex:count];
        if ([[file pathExtension] isEqualToString:@"pdf"]) {
            filePath = [path stringByAppendingPathComponent:file];
        }
        //NSLog(@"File %d: %@", (count + 1), [directoryContent objectAtIndex:count]);
    }

    
    if (![FileHelper fileExists:filePath isDir:NO]) {
        NSString *pdfFile = [[[[FileHelper booksPath]stringByAppendingPathComponent:bookEntity.folder] stringByAppendingPathComponent:@"F_PDF"]stringByAppendingPathExtension:@"pdf"];
        filePath = pdfFile;
    }
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase bookEntity:bookEntity];
    
    if (document != nil) // Must have a valid ReaderDocument object in order to proceed
    {
        readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        //[self.navigationController pushViewController:readerViewController animated:YES];
        
        // present in a modal view controller
        
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:readerViewController animated:YES completion:NULL];
    }

}

-(void)dismissReaderViewController:(ReaderViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - Interactive Reader

-(void)readerInteractive:(BookEntity*)book{
    /*InteractiveReader *reader = [[InteractiveReader alloc] initWithBook:book];
    [self.navigationController pushViewController:reader animated:YES];*/
    BakerBook *baker = [[BakerBook alloc] initWithBookEntity:book];
    BakerViewController *bakerViewController = [[BakerViewController alloc] initWithBook:baker];
    if (bakerViewController) {
        [self.navigationController pushViewController:bakerViewController animated:YES];
    } else {
        NSLog(@"[ERROR] Book %@ could not be initialized", book.bookID);
//        issue.transientStatus = BakerIssueTransientStatusNone;
//        // Let's refresh everything as it's easier. This is an edge case anyway ;)
//        for (IssueViewController *controller in issueViewControllers) {
//            [controller refresh];
//        }
        [Utils showAlertWithTitle:NSLocalizedString(@"ISSUE_OPENING_FAILED_TITLE", nil)
                          message:NSLocalizedString(@"ISSUE_OPENING_FAILED_MESSAGE", nil)
                      buttonTitle:NSLocalizedString(@"ISSUE_OPENING_FAILED_CLOSE", nil)];
    }
}

#pragma mark - Login deleagte

-(void)didLoginViewController:(LoginViewController *)logingView
{
    [KKBookService requestLoginService:logingView.usernameField.text password:logingView.passwordField.text complete:^(NSDictionary *response, NSError *error){
        if (!error) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            
            [userDefault setObject:[response objectForKey:@"FName"] forKey:@"fname"];
            [userDefault setObject:[response objectForKey:@"LName"] forKey:@"lname"];
            [userDefault setObject:[response objectForKey:@"Email"] forKey:@"email"];
            [userDefault setObject:[[response objectForKey:@"Birthday"] isKindOfClass:[NSNull class]] ? @"":[response objectForKey:@"Birthday"] forKey:@"bdate"];
            [userDefault setBool:YES forKey:IS_LOGIN];
            [userDefault synchronize];
            [logingView dismissViewControllerAnimated:YES completion:^{
                NSLog(@"name: %@",[response objectForKey:@"FName"]);
            }];
        }else{
            [BaseViewController showAlertWithMessage:@"Login fail! please login again."];
        }
    }];
}

#pragma mark - User delegate

-(void)didLogout:(UserViewController *)viewController{
    [self.leftSideBar didTapItemAtIndex:_pageType];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:NO forKey:IS_LOGIN];
    [userDefault synchronize];
    [self viewDidAppear:YES];
    
}

-(void)didCloseView:(UserViewController *)viewController{
    [self.leftSideBar didTapItemAtIndex:_pageType];
}

#pragma mark - UIAlert delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setBool:NO forKey:IS_LOGIN];
        [userDefault synchronize];
        [self viewDidAppear:YES];
    }
}


@end
