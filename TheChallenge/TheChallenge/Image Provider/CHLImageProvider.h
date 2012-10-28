//
//  CHLImageProvider.h
//  
//
//  Created by Aleksander Zubala
//  
//

#import <Foundation/Foundation.h>
#import "CHLDownloaderQueue.h"

@interface CHLImageProvider : CHLDownloaderQueue

// factory method
+ (id) defaultProvider;

// provider methods
- (void) imageWithURL:(NSURL*)imageURL scale:(CGFloat)scale completionBlock:(void(^)(BOOL success,UIImage *image))completionBlock;

- (void) cancelDownloadForURL:(NSURL*)imageURL;

- (void) clearCache;
- (void) clearCacheForURL:(NSURL*)imageURL;

@end
