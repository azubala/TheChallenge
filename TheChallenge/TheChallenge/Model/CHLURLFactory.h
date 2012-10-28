//
//  CHLURLFactory.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import <Foundation/Foundation.h>

@interface CHLURLFactory : NSObject

+ (id) defaultFactory;

- (NSURL*) userTracksURL;
- (NSURL*) userFavoritesURL;
- (NSURL*) userFollowingsURL;

@end
