//
//  KKBookPreviewVCViewController.m
//  KKBooK
//
//  Created by PromptNow Ltd. on 12/11/14.
//  Copyright (c) 2014 GLive. All rights reserved.
//

#import "KKBookPreviewVC.h"
#import "PhotoViewController.h"

@interface KKBookPreviewVC (){
    NSInteger currentIndex;
}

@end

@implementation KKBookPreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initPageViewController];
    self.title = @"PREVIEW";
}

/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initPageViewController{
    self.pageViewControler = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewControler.view.frame = self.view.frame;
    _pageViewControler.dataSource = self;
    _pageViewControler.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageViewControler.view];
    if (_previews > 0 && _previews) {
        currentIndex = 0;
        PhotoViewController *pageZero = [PhotoViewController photoViewControllerForPagePreView:[NSURL URLWithString:_previews[0]]];
        if (pageZero) {
            [_pageViewControler setViewControllers:@[pageZero]
                                         direction:UIPageViewControllerNavigationDirectionForward
                                          animated:NO
                                        completion:NULL];
            
        }

    }
}

#pragma mark - UIPageViewController datasource

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(PhotoViewController *)vc
{
    currentIndex -= 1;
    if (currentIndex > 0) {
        return [PhotoViewController photoViewControllerForPagePreView:[NSURL URLWithString:_previews[currentIndex]]];
    }else
        return nil;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(PhotoViewController *)vc
{
    currentIndex += 1;
    if (currentIndex < _previews.count) {
        return [PhotoViewController photoViewControllerForPagePreView:[NSURL URLWithString:_previews[currentIndex]]];
    }else
        return nil;
    
}*/

#pragma mark - ColelctionViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullCollectionCell" forIndexPath:indexPath];
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}



/*
 HWViewPagerDelegate
 connection IBOulet with Storyboard
 
 or
 call method : " [pager setPagerDelegate:id] "
 
 */

#pragma mark - HWViewPagerDelegate
-(void)pagerDidSelectedPage:(NSInteger)selectedPage{
    /*NSLog(@"FistViewController, SelectedPage : %ld",selectedPage);
    NSString * string = [NSString stringWithFormat:@"SectionInset left,right = 30\nminLinespacing =20\nSelectedPage : %ld",selectedPage];
    self.label.text = string;*/
}

@end
