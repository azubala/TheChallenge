//
//  CHLUserObject.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLBaseModelObject.h"

@interface CHLUserObject : CHLBaseModelObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSURL *avatarURL;

@end