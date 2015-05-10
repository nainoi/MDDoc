
#import "MHPagingScrollView.h"

@interface PreviewViewController : UIViewController <MHPagingScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet MHPagingScrollView *pagingScrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property(strong, nonatomic) NSArray *previews;

- (IBAction)pageTurn;

@end
