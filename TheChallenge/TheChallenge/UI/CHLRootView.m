//
//  CHLRootView.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "CHLRootView.h"

@implementation CHLRootView
@synthesize spinner = _spinner, infoLabel = _infoLabel, loginButton = _loginButton;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_spinner setHidesWhenStopped:YES];
        [self addSubview:_spinner];
        
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_infoLabel];
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self addSubview:_loginButton];
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - layouts & drawing

- (void) layoutSubviews
{
    [super layoutSubviews];
    _spinner.center = self.center;    
}


@end
