//
//  CHLViewScroller.h
//  
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import <UIKit/UIKit.h>

@protocol CHLViewScrollerDelegate;

@interface CHLViewScroller : UIView <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UILabel *_titleLabel;
    UIButton *_rightButton;

    NSArray *_viewsToScroll;
}

@property (nonatomic, strong) NSArray *viewsToScroll; //dynamic setter

@property (nonatomic, readonly) UIPageControl *pageControl;
@property (nonatomic, readonly) UIButton *rightButton;
@property (nonatomic, readonly) NSInteger currentPageIndex;

@property (nonatomic, weak) id <CHLViewScrollerDelegate> delegate;

@property (nonatomic) CGFloat pageControlHeight;


- (void) scrollToViewAtIndex:(NSUInteger)index animated:(BOOL)animated;

@end

//---------------------------------------------------------------------------------------------

@protocol CHLViewScrollerDelegate <NSObject>
@optional

- (NSString*) viewScroller:(CHLViewScroller*)viewScroller titleForPageAtIndex:(NSInteger)index;

@end
