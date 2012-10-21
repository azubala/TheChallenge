//
//  CHLViewScroller.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "CHLViewScroller.h"

@implementation CHLViewScroller
@synthesize viewsToScroll = _viewsToScroll;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor underPageBackgroundColor];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
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
            [self addSubview:view];
        }
        [self setNeedsLayout];
    }
}

//---------------------------------------------------------------------------------------------
#pragma mark - layouts & drawing

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGSize viewSize = self.bounds.size;
    CGRect subviewRect = CGRectMake(0.0f, 0.0f, viewSize.width, viewSize.height); 
    CGAffineTransform translation = CGAffineTransformMakeTranslation(viewSize.width, 0.0f);
    for (UIView *view in _viewsToScroll) {
        view.frame = subviewRect;
        subviewRect = CGRectApplyAffineTransform(subviewRect, translation);
    }
    
    if ([_viewsToScroll count]) {
        self.contentSize = CGSizeMake(CGRectGetMaxX([[_viewsToScroll lastObject] frame]), viewSize.height);
    }
}

@end
