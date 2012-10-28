//
//  CHLUsersParser.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLUsersParser.h"
#import "CHLUserObject.h"

@implementation CHLUsersParser

//---------------------------------------------------------------------------------------------
#pragma mark - parsing

- (NSArray*) parseRawItems:(NSArray *)rawItems
{
    NSMutableArray *usersList = [[NSMutableArray alloc] init];
    for (NSDictionary *userDict in rawItems) {
        CHLUserObject *userObject = [[CHLUserObject alloc] init];
        [userObject parseDataFromDictionary:userDict];
        [usersList addObject:userObject];
    }
    return usersList;
}

@end
