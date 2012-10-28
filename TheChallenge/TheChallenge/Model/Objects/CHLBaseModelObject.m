//
//  CHLBaseModelObject.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLBaseModelObject.h"

@implementation CHLBaseModelObject

//---------------------------------------------------------------------------------------------
#pragma mark - parsing

- (void) parseDataFromDictionary:(NSDictionary*)dictionary
{
    self.objectId = dictionary[@"id"];
    self.creationDate = dictionary[@"created_at"];
}

@end
