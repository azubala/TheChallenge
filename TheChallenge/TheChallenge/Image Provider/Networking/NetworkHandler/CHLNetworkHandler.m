//
//  CHLNetworkHandler.m
//  
//
//  Created by Aleksander Zubala
//  
//

#import "CHLNetworkHandler.h"
//#define HANDLER_DEBUG

@interface CHLNetworkHandler ()

@end


@implementation CHLNetworkHandler
@synthesize userDataDict,connectionTimeout,blockProgress,postParams;

//---------------------------------------------------------------------------------------------
#pragma mark - object lifecycle

- (id)init 
{
    self = [super init];
    if (self) {
        userDataDict = [[NSMutableDictionary alloc] init];
        postParams = [[NSMutableDictionary alloc] init];
        connectionTimeout = 15;
        excpectedContentSize = 0;
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - helpers

- (NSFileHandle*) createFileAtPath:(NSString*)aFileName
{
    [[NSFileManager defaultManager] createFileAtPath:aFileName contents:nil attributes:nil];
    return  [NSFileHandle fileHandleForUpdatingAtPath:aFileName];
}

//---------------------------------------------------------------------------------------------
#pragma mark - post dict handling

- (void) setPostParamsForRequest:(NSMutableURLRequest*)aRequest
{
    NSString *post = @"";
    for(NSString *key in [postParams allKeys]){
        post = [post stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[postParams objectForKey:key]]];
    }
    
    if ([post length]) {
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];	
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        [aRequest setHTTPMethod:@"POST"]; 
        [aRequest setValue:postLength forHTTPHeaderField:@"Content-Length"]; 
        [aRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; 
        [aRequest setHTTPBody:postData];	
    }
}

//---------------------------------------------------------------------------------------------
#pragma handling requests

- (NSString*) sendSyncRequestWithURL:(NSURL*)aURL
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:aURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:connectionTimeout];
    [self setPostParamsForRequest:request];
#ifdef HANDLER_DEBUG
    NSLog(@"Sending request %@ to url:%@",request,aURL);
#endif
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *respData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = nil;
    if (response && !error) {
        responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
    } else {
        NSLog(@"Error while sending sync request:%@",[error localizedDescription]);
    }
    return responseString;
}

- (void) sentRequestWithURL:(NSURL*)aURL withBlockSuccess:(void (^)(NSData*,CHLNetworkHandler*))aBlockSuccess blockFail:(void (^)(CHLNetworkHandler*))aBlockFailed;
{
    blockSuccessWithData = [aBlockSuccess copy];
    blockFailed = [aBlockFailed copy];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:aURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:connectionTimeout];
    [self setPostParamsForRequest:request];
#ifdef HANDLER_DEBUG
    NSLog(@"Sending request %@ to url:%@",request,aURL);
#endif
    urlConnectionDataResponse = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(urlConnectionDataResponse){
        receivedData = [NSMutableData data];
    }else {
#ifdef HANDLER_DEBUG        
        NSLog(@"Failed to init url connection");
#endif
    }
}

- (void) sentRequestWithURL:(NSURL*)aURL saveResponseToFile:(NSString*) aFilename withBlockSuccess:(void (^)(NSString*,CHLNetworkHandler*))aBlockSuccess blockFail:(void (^)(CHLNetworkHandler*))aBlockFailed;
{
    blockSuccessWithFile = aBlockSuccess;
    blockFailed = aBlockFailed;
    fileName = aFilename;

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:aURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:connectionTimeout];
    [self setPostParamsForRequest:request];
#ifdef HANDLER_DEBUG
    NSLog(@"Sending request %@ to url:%@",request,aURL);
#endif
    ulrConnectionFileResponse = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(ulrConnectionFileResponse){
        responseFile = [self createFileAtPath:aFilename];
    } else {
#ifdef HANDLER_DEBUG        
        NSLog(@"Failed to init url connection");
#endif        
    }
}

//---------------------------------------------------------------------------------------------
#pragma mark - canceling

- (void) cancelRequest
{
    [urlConnectionDataResponse cancel];
    [ulrConnectionFileResponse cancel];
}

//---------------------------------------------------------------------------------------------
#pragma mark - NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	if (connection == ulrConnectionFileResponse) {
        [responseFile seekToEndOfFile];
        [responseFile writeData:data];
        [responseFile synchronizeFile];
    } else if (connection == urlConnectionDataResponse) {
        [receivedData appendData:data];    
    }
    
    if (blockProgress) {
        downloadedContentSize += [data length];
        CGFloat downloadProgress = (CGFloat)downloadedContentSize/(CGFloat)excpectedContentSize;
        blockProgress(downloadProgress);
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    if (connection == ulrConnectionFileResponse) {
		[responseFile seekToEndOfFile];
    } else if (connection == urlConnectionDataResponse) {
        [receivedData setLength:0];
    }
    downloadedContentSize = 0;
    excpectedContentSize = [response expectedContentLength];
#ifdef HANDLER_DEBUG    
	NSLog(@"Excpected size:%lld",excpectedContentSize);
#endif
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    blockFailed(self);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection 
{
    if (connection == ulrConnectionFileResponse) {
        [responseFile closeFile];
        blockSuccessWithFile(fileName,self);
    } else if (connection == urlConnectionDataResponse) {
        blockSuccessWithData(receivedData,self);
    }
}


@end
