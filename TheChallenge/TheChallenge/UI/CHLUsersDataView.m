//
//  CHLUsersDataView.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "CHLUsersDataView.h"

@implementation CHLUsersDataView
@synthesize listsScroller = _listsScroller, pageControl = _pageControl, logoutButton = _logoutButton;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _listsScroller = [[CHLViewScroller alloc] initWithFrame:CGRectZero];
        [self addSubview:_listsScroller];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.numberOfPages = 3;
        _pageControl.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_pageControl];
        
        _logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self addSubview:_logoutButton];
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - layouts & drawing

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGSize viewSize = self.bounds.size;
    
    _listsScroller.frame = self.bounds;
    
    CGPoint pos = CGPointZero;
    CGSize pageControllerSize = CGSizeMake(viewSize.width, 40.0f);
    pos.y = viewSize.height - pageControllerSize.height;
    _pageControl.frame = CGRectMake(pos.x, pos.y, pageControllerSize.width, pageControllerSize.height);
    
    CGSize buttonSize = CGSizeMake(40.0f, 40.0f);
    pos.x = viewSize.width - buttonSize.width;
    pos.y = 0.0f;
    _logoutButton.frame = CGRectMake(pos.x, pos.y, buttonSize.width, buttonSize.height);
    
}

@end
