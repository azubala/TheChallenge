//
//  CHLDownloaderQueue.h
//  
//
//  Created by Aleksander Zubala
//  
//

#import <Foundation/Foundation.h>


@interface CHLDownloaderQueue : NSObject {
    NSMutableDictionary *downloaderDict;
}

- (void) addObjectDownloadWithURL:(NSURL*)aURL 
              withCompletionBlock:(void(^)(BOOL,NSData* data))aCompletionBlock;

- (void) addObjectDownloadWithURL:(NSURL *)aURL 
              fileNameInDocuments:(NSString*)aFileName 
              withCompletionBlock:(void (^)(BOOL success,NSString* filePath))aCompletionBlock;

- (void) addObjectDownloadWithURL:(NSURL *)aURL 
              fileNameInDocuments:(NSString*)aFileName 
              withCompletionBlock:(void (^)(BOOL success,NSString*filePath))aCompletionBlock 
            downloadProgressBlock:(void(^)(CGFloat progress))aProgressBlock 
                       paramsDict:(NSDictionary*)requestParams;


- (NSString*) uniqueKeyFromURL:(NSURL*)aURL postParams:(NSDictionary*)postParams;
- (void) cancelAll;

@end
