//
//  CHLUsersDataView.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "CHLUsersDataView.h"

@implementation CHLUsersDataView
@synthesize listsScroller = _listsScroller, logoutButton = _logoutButton;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithFrame:(CGRect)frame gradientColors:(NSArray *)colorsList
{
    self = [super initWithFrame:frame gradientColors:colorsList];
    if (self) {
        _listsScroller = [[CHLViewScroller alloc] initWithFrame:CGRectZero];
        [self addSubview:_listsScroller];
        
        
        _logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

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
    CGSize buttonSize = CGSizeMake(40.0f, 40.0f);
    pos.x = viewSize.width - buttonSize.width;
    pos.y = 0.0f;
    _logoutButton.frame = CGRectMake(pos.x, pos.y, buttonSize.width, buttonSize.height);
    
}

@end
