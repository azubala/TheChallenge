//
//  CHLUserObject.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLUserObject.h"

@implementation CHLUserObject
@synthesize username = username_, avatarURL = avatarURL_;

//---------------------------------------------------------------------------------------------
#pragma mark - parsing

- (void) parseDataFromDictionary:(NSDictionary *)dictionary
{
    [super parseDataFromDictionary:dictionary];

    self.username = dictionary[@"username"];
    self.avatarURL = [NSURL URLWithString:dictionary[@"avatar_url"]];
}

@end
