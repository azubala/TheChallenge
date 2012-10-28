//
//  CHLBaseModelObject.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLBaseModelObject.h"

NSDateFormatter *staticDateFormater_;

@implementation CHLBaseModelObject

//---------------------------------------------------------------------------------------------
#pragma mark - parsing

- (void) parseDataFromDictionary:(NSDictionary*)dictionary
{
    self.objectId = dictionary[@"id"];
    
    NSString *dateString = dictionary[@"created_at"];
    self.creationDate = [[CHLBaseModelObject dateFormatter] dateFromString:dateString];
}

//---------------------------------------------------------------------------------------------
#pragma mark - date formater

+ (NSDateFormatter*) dateFormatter
{
    if (!staticDateFormater_) {
        staticDateFormater_ = [[NSDateFormatter alloc] init];
        [staticDateFormater_ setDateFormat:@"yyyy/MM/dd HH:mm:ss ZZZ"];
    }
    return staticDateFormater_;
}

@end
