//
//  CHLSoundCloudItemParserProtocol.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

/**
 Defines protocol for parser of sound cloud items, fetched by API
 **/

#import <Foundation/Foundation.h>

@protocol CHLSoundCloudItemParserProtocol <NSObject>

@required

// Method used to parse raw data from JSON serialization, that is arrays and dictionaries, into concrete model objects.
- (NSArray*) parseRawItems:(NSArray*)rawItems;


@end
