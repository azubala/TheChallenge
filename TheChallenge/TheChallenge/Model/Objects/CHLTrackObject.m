//
//  CHLTrackObject.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLTrackObject.h"
#import "CHLUsersParser.h"

@implementation CHLTrackObject
@synthesize title = title_, waveFormURL = waveFormURL_, author = author_;

//---------------------------------------------------------------------------------------------
#pragma mark - parsing

- (void) parseDataFromDictionary:(NSDictionary *)dictionary
{
    [super parseDataFromDictionary:dictionary];
    
    self.title = dictionary[@"title"];
    self.waveFormURL = [NSURL URLWithString:dictionary[@"waveform_url"]];
    
    NSDictionary *authorDict = dictionary[@"user"];
    if (authorDict) {
        CHLUsersParser *parser = [[CHLUsersParser alloc] init];
        self.author = [[parser parseRawItems:@[authorDict]] lastObject];
    }
}

@end
