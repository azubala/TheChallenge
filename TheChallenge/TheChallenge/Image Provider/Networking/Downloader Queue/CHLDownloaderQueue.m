//
//  CHLDownloaderQueue.m
//  
//
//  Created by Aleksander Zubala
// 
//

#import "CHLDownloaderQueue.h"
#import "CHLNetworkHandler.h"

@implementation CHLDownloaderQueue

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)init 
{
    self = [super init];
    if (self) {
        downloaderDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - helpers

- (NSString*) uniqueKeyFromURL:(NSURL*)aURL postParams:(NSDictionary*)postParams
{
    NSString *aKey = [NSString stringWithFormat:@"%@",aURL];
    for (NSString *key in [postParams allKeys]) {
        aKey = [aKey stringByAppendingFormat:@"_%@:%@",key,[postParams objectForKey:key]];
    }
    return aKey;
}

//---------------------------------------------------------------------------------------------
#pragma mark - setting up downloads

- (void) startDownloadProcessForURL:(NSURL*)aURL 
                    completionBlock:(void(^)(BOOL,id))aCompletionBlock 
                   resultSaveToFile:(NSString*)aResultFileName 
              downloadProgressBlock:(void(^)(CGFloat))aProgressBlock 
                         paramsDict:(NSDictionary*)requestParams
{
    NSString *downloaderQueueKey = [self uniqueKeyFromURL:aURL postParams:requestParams];
    CHLNetworkHandler *aNetHandler = [downloaderDict objectForKey:downloaderQueueKey];
    if (!aNetHandler && aURL) {
        aNetHandler = [[CHLNetworkHandler alloc] init];
        [aNetHandler setPostParams:[NSMutableDictionary dictionaryWithDictionary:requestParams]];
        [aNetHandler setBlockProgress:aProgressBlock];
        [downloaderDict setObject:aNetHandler forKey:downloaderQueueKey];
        
        void (^blockFail)(CHLNetworkHandler*) = ^(CHLNetworkHandler *aNetHandler) {
            if (aResultFileName) {
                [[NSFileManager defaultManager] removeItemAtPath:aResultFileName error:NULL];
            }
            aCompletionBlock(NO,nil);
            [downloaderDict removeObjectForKey:downloaderQueueKey];
        };
        
        if (aResultFileName) {
            [aNetHandler sentRequestWithURL:aURL saveResponseToFile:aResultFileName withBlockSuccess:^(NSString *aFileName, CHLNetworkHandler *aNetHndl) {
                aCompletionBlock(YES,aFileName);
                [downloaderDict removeObjectForKey:downloaderQueueKey];
            } blockFail:blockFail];
            
        } else {
            [aNetHandler sentRequestWithURL:aURL withBlockSuccess:^(NSData *receivedData, CHLNetworkHandler *aNetHndl) {
                aCompletionBlock(YES,receivedData);
                [downloaderDict removeObjectForKey:downloaderQueueKey];
            } blockFail:blockFail];
        }
        
    } else {
#ifdef DEBUG        
        NSLog(@"Object with:%@ aleready is in download queue!",downloaderQueueKey);
#endif
        aCompletionBlock(NO,nil);
    }
}

- (void) addObjectDownloadWithURL:(NSURL*)aURL 
              withCompletionBlock:(void(^)(BOOL,NSData* data))aCompletionBlock
{
    [self startDownloadProcessForURL:aURL completionBlock:^(BOOL success, id data){
        aCompletionBlock(success, (NSData*)data);
    } resultSaveToFile:nil downloadProgressBlock:nil paramsDict:nil];
}

- (void) addObjectDownloadWithURL:(NSURL *)aURL 
              fileNameInDocuments:(NSString*)aFileName 
              withCompletionBlock:(void (^)(BOOL success,NSString*filePath))aCompletionBlock 
            downloadProgressBlock:(void(^)(CGFloat progress))aProgressBlock 
                       paramsDict:(NSDictionary*)requestParams
{
    [self startDownloadProcessForURL:aURL completionBlock:^(BOOL success,id data){
        aCompletionBlock(success,(NSString*)data);
    } resultSaveToFile:aFileName downloadProgressBlock:aProgressBlock paramsDict:requestParams];
}

- (void) addObjectDownloadWithURL:(NSURL *)aURL 
              fileNameInDocuments:(NSString*)aFileName 
              withCompletionBlock:(void (^)(BOOL success,NSString* filePath))aCompletionBlock
{
    [self startDownloadProcessForURL:aURL completionBlock:^(BOOL success,id data){
        aCompletionBlock(success,(NSString*)data);
    } resultSaveToFile:aFileName downloadProgressBlock:nil paramsDict:nil];
}

//---------------------------------------------------------------------------------------------
#pragma mark - cancelling active requests

- (void) cancelAll
{
    for (NSURL *aURL in [downloaderDict allKeys]) {
        [[downloaderDict objectForKey:aURL] cancelRequest];
    }
    [downloaderDict removeAllObjects];
}

@end
