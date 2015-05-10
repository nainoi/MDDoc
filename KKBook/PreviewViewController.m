
#import "PreviewViewController.h"
#import "PageView.h"
#import "ImageScrollView.h"

@implementation PreviewViewController
{
	NSUInteger _numPages;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	_numPages = _previews.count;

	self.pagingScrollView.previewInsets = UIEdgeInsetsMake(0.0, 80.0, 0.0, 80.0);
	[self.pagingScrollView reloadPages];

	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = _numPages;
}

//- (void)didReceiveMemoryWarning
//{
//	[self.pagingScrollView didReceiveMemoryWarning];
//}

#pragma mark - Actions

- (IBAction)pageTurn
{
	[self.pagingScrollView selectPageAtIndex:self.pageControl.currentPage animated:YES];
}

#pragma mark - View Controller Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.pagingScrollView beforeRotation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.pagingScrollView afterRotation];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)theScrollView
{
	self.pageControl.currentPage = [self.pagingScrollView indexOfSelectedPage];
	[self.pagingScrollView scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView
{
	/*if ([self.pagingScrollView indexOfSelectedPage] == _numPages - 1)
	{
		_numPages++;
		[self.pagingScrollView reloadPages];
		self.pageControl.numberOfPages = _numPages;
	}*/
}

#pragma mark - MHPagingScrollViewDelegate

- (NSUInteger)numberOfPagesInPagingScrollView:(MHPagingScrollView *)pagingScrollView
{
	return _numPages;
}

- (UIView *)pagingScrollView:(MHPagingScrollView *)thePagingScrollView pageForIndex:(NSUInteger)index
{
	PageView *pageView = (PageView *)[thePagingScrollView dequeueReusablePage];
	if (pageView == nil)
		pageView = [[PageView alloc] init];

	[pageView setImageURL:[NSURL URLWithString:_previews[index]]];
	return pageView;
    
    /*ImageScrollView *imageScroll = (ImageScrollView*)[thePagingScrollView dequeueReusablePage];
    if (!imageScroll) {
        imageScroll = [[ImageScrollView alloc] init];
    }
    [imageScroll displayImageURL:[NSURL URLWithString:_previews[index]]];
    return imageScroll;*/
}

@end
