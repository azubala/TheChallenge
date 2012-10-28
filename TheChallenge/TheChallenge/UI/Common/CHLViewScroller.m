//
//  CHLViewScroller.m
//  
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "CHLViewScroller.h"
#import "UILabel+MeasuringTextHelpers.h"

@implementation CHLViewScroller
@synthesize viewsToScroll = _viewsToScroll, pageControl = _pageControl, currentPageIndex = _currentPageIndex, pageControlHeight = _pageControlHeight;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pageControlHeight = 40.0f;
        _currentPageIndex = 0;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:.3f];
        [self addSubview:_pageControl];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor blackColor];
        _titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [self addSubview:_titleLabel];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_rightButton setTitle:@"Logout" forState:UIControlStateNormal];
        [self addSubview:_rightButton];
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - dynamic setter

- (void) setViewsToScroll:(NSArray *)viewsToScroll
{
    if (_viewsToScroll != viewsToScroll) {
        for (UIView *view in _viewsToScroll) {
            [view removeFromSuperview];
        }
        _viewsToScroll = viewsToScroll;
        for (UIView *view in _viewsToScroll) {
            [_scrollView addSubview:view];
            [self sendSubviewToBack:view];
            if ([view isKindOfClass:[UIScrollView class]]) {
                [(UIScrollView*)view setContentInset:UIEdgeInsetsMake(.0f, .0f, _pageControlHeight, .0f)];
            }
        }
        [_pageControl setNumberOfPages:[_viewsToScroll count]];
        [self setNeedsLayout];
        [self updateTitleLabelForIndex:0];
    }
}

//---------------------------------------------------------------------------------------------
#pragma mark - layouts & drawing

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGSize viewSize = self.bounds.size;
    
    CGRect scrollRect = _scrollView.frame;
    scrollRect.size = viewSize;
    _scrollView.frame = scrollRect;
    
    CGRect subviewRect = CGRectMake(0.0f, 0.0f, viewSize.width, viewSize.height); 
    CGAffineTransform translation = CGAffineTransformMakeTranslation(viewSize.width, 0.0f);
    for (UIView *view in _viewsToScroll) {
        view.frame = subviewRect;
        subviewRect = CGRectApplyAffineTransform(subviewRect, translation);
    }
    
    if ([_viewsToScroll count]) {
        _scrollView.contentSize = CGSizeMake(CGRectGetMaxX([[_viewsToScroll lastObject] frame]), viewSize.height);
    }
    
    CGSize pageControlSize = CGSizeMake(viewSize.width, _pageControlHeight);
    CGPoint pos = CGPointMake(0.0f, viewSize.height - pageControlSize.height);
    _pageControl.frame = CGRectMake(pos.x, pos.y, pageControlSize.width, pageControlSize.height);
    
    CGFloat bottomSpacing = 5.0f;
    CGSize titleSize = [_titleLabel sizeOfLabelConstrainedToSize:_pageControl.frame.size];
    pos.x += bottomSpacing;
    pos.y += floorf((pageControlSize.height - titleSize.height)/2);
    _titleLabel.frame = CGRectMake(pos.x, pos.y, titleSize.width, titleSize.height);
    
    CGSize buttonSize = CGSizeMake(60.0f, pageControlSize.height - 2*bottomSpacing);
    pos.x = viewSize.width - bottomSpacing - buttonSize.width;
    pos.y = CGRectGetMinY(_pageControl.frame) + bottomSpacing;
    _rightButton.frame = CGRectMake(pos.x, pos.y, buttonSize.width, buttonSize.height);
}

//---------------------------------------------------------------------------------------------
#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self updateSelectedPageForPageControl];
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateSelectedPageForPageControl];
}

//---------------------------------------------------------------------------------------------
#pragma mark - misc

- (void) updateSelectedPageForPageControl
{
    NSInteger index = [self currentPageIndex];
    [_pageControl setCurrentPage:index];
    [self updateTitleLabelForIndex:index];
}

- (void) updateTitleLabelForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(viewScroller:titleForPageAtIndex:)]) {
        _titleLabel.text = [self.delegate viewScroller:self titleForPageAtIndex:index];
        [self setNeedsLayout];
    }
}

- (NSInteger) currentPageIndex
{
    return floorf( _scrollView.contentOffset.x / self.bounds.size.width );
}

- (void) scrollToViewAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    CGPoint contentOffset = CGPointMake(self.bounds.size.width * index, 0.0f);
    [_scrollView setContentOffset:contentOffset animated:animated];
    [_pageControl setCurrentPage:index];
}

@end
