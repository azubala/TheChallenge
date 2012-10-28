//
//  CHLTracksParser.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLTracksParser.h"
#import "CHLTrackObject.h"

@implementation CHLTracksParser

//---------------------------------------------------------------------------------------------
#pragma mark - CHLSoundCloudItemParserProtocol

- (NSArray*) parseRawItems:(NSArray *)rawItems
{
    NSMutableArray *parsedItems = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in rawItems) {
        CHLTrackObject *track = [[CHLTrackObject alloc] init];
        [track parseDataFromDictionary:dictionary];
        [parsedItems addObject:track];
    }
    return parsedItems;
}

@end
