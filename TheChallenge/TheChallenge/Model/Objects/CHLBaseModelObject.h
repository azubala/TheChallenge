//
//  CHLBaseModelObject.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import <Foundation/Foundation.h>

@interface CHLBaseModelObject : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDate *creationDate;

- (void) parseDataFromDictionary:(NSDictionary*)dictionary;

@end
