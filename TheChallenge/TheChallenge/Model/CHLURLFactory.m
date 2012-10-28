//
//  CHLURLFactory.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLURLFactory.h"

CHLURLFactory *_defaultFactory = nil;

@implementation CHLURLFactory
{
    NSURL *_baseURL;
}

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)init
{
    self = [super init];
    if (self) {
        _baseURL = [NSURL URLWithString:@"https://api.soundcloud.com"];
    }
    return self;
}

+ (id) defaultFactory
{
    @synchronized(self) {
        if (!_defaultFactory) {
            _defaultFactory = [[self alloc] init];
        }
        return _defaultFactory;
    }
}

//---------------------------------------------------------------------------------------------
#pragma mark - url methods

- (NSURL*) userSpecificURL
{
    return [_baseURL URLByAppendingPathComponent:@"me"];
}

- (NSURL*) userTracksURL
{
    return [[self userSpecificURL] URLByAppendingPathComponent:@"tracks.json"];
}

- (NSURL*) userFavoritesURL
{
    return [[self userSpecificURL] URLByAppendingPathComponent:@"favorites.json"];
}


- (NSURL*) userFollowingsURL
{
    return [[self userSpecificURL] URLByAppendingPathComponent:@"followings.json"];
}


@end
