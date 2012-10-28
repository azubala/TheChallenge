//
//  CHLNetworkHandler.h
//  
//
//  Created by Aleksander Zubala
//  
//

#import <Foundation/Foundation.h>

@interface CHLNetworkHandler : NSObject{
    NSURLConnection *urlConnectionDataResponse, *ulrConnectionFileResponse;
    NSInteger connectionTimeout;
    
    NSMutableData *receivedData;
    NSFileHandle *responseFile;
    NSString *fileName;
    
    NSMutableDictionary *userDataDict, *postParams;
    long long excpectedContentSize, downloadedContentSize;
    
    void (^blockSuccessWithData)(NSData*,CHLNetworkHandler*);
    void (^blockSuccessWithFile)(NSString*,CHLNetworkHandler*);
    void (^blockFailed)(CHLNetworkHandler*);
    void (^blockProgress)(CGFloat);
}

@property (nonatomic) NSInteger connectionTimeout;
@property (nonatomic, strong) NSMutableDictionary *userDataDict;
@property (nonatomic, strong) void (^blockProgress)(CGFloat);
@property (nonatomic, strong) NSMutableDictionary *postParams;

- (void) sentRequestWithURL:(NSURL*)aURL withBlockSuccess:(void (^)(NSData*,CHLNetworkHandler*))aBlockSuccess blockFail:(void (^)(CHLNetworkHandler*))aBlockFailed;
- (void) sentRequestWithURL:(NSURL*)aURL saveResponseToFile:(NSString*) aFilename withBlockSuccess:(void (^)(NSString*,CHLNetworkHandler*))aBlockSuccess blockFail:(void (^)(CHLNetworkHandler*))aBlockFailed;
- (NSString*) sendSyncRequestWithURL:(NSURL*)aURL;
- (void) cancelRequest;

@end
