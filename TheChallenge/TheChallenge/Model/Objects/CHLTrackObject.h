//
//  CHLTrackObject.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLBaseModelObject.h"
#import "CHLUserObject.h"

@interface CHLTrackObject : CHLBaseModelObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *waveFormURL;

@property (nonatomic, strong) CHLUserObject *author;

@end
