//
//  CHLImageProvider.m
//  
//
//  Created by Aleksander Zubala
//  
//

#import "CHLImageProvider.h"
#import "CHLNetworkHandler.h"

static CHLImageProvider *defaultProvider_;

@implementation CHLImageProvider

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

+ (id) defaultProvider
{
    if (!defaultProvider_) {
        defaultProvider_ = [[CHLImageProvider alloc] init];
    }
    return defaultProvider_;
}

- (void) dealloc
{
    [self clearCache];
}

//---------------------------------------------------------------------------------------------
#pragma mark - image provider paths

- (NSString*) cacheFolderPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

- (NSString*) providerCacheFolderPath
{
    NSString *folderPath = [[self cacheFolderPath] stringByAppendingPathComponent:NSStringFromClass([self class])];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            folderPath = nil;
        }
    }
    return folderPath;
}

- (NSString*) imageFileNameFromURL:(NSURL*)imageURL
{
    NSString *fileName = [imageURL relativeString];
    fileName = [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return fileName;
}

//---------------------------------------------------------------------------------------------
#pragma mark - providing images

- (UIImage*) imageFromPath:(NSString*)imagePath
{
    UIImage *retImage = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        retImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    }
    return retImage;
}

- (void) imageWithURL:(NSURL*)imageURL scale:(CGFloat)scale completionBlock:(void(^)(BOOL success,UIImage *image))completionBlock
{
    if (!imageURL) {
        completionBlock(NO,nil);
        return;
    }
    NSString *fileName = [self imageFileNameFromURL:imageURL];
    NSString *imageFullPath = [[self providerCacheFolderPath] stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imageFullPath]) {
        completionBlock(YES,[self imageFromPath:imageFullPath]);
    } else {
        CHLImageProvider * __weak provider = self;
        [self addObjectDownloadWithURL:imageURL fileNameInDocuments:imageFullPath withCompletionBlock:^(BOOL success, NSString *filePath) {
            
            UIImage *image = [provider imageFromPath:filePath];
            if (scale != 1.0f && scale != 0.0f) {
                CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scale, scale);
                CGSize scaledSize = CGSizeApplyAffineTransform(image.size, scaleTransform);
                UIGraphicsBeginImageContext(scaledSize);
                [image drawInRect:CGRectMake(0.0, 0.0, scaledSize.width, scaledSize.height)];
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [UIImagePNGRepresentation(image) writeToFile:filePath atomically:NO];
            }
            completionBlock(success,image);
        }];
    }
}

//---------------------------------------------------------------------------------------------
#pragma mark - cache clearing and cancelling

- (void) cancelDownloadForURL:(NSURL*)imageURL
{
    NSString *netHandlerKey = [self uniqueKeyFromURL:imageURL postParams:nil];
    CHLNetworkHandler *netHndl = [downloaderDict objectForKey:netHandlerKey];
    if (netHndl) {
        [netHndl cancelRequest];
        [downloaderDict removeObjectForKey:netHandlerKey];
        [self clearCacheForURL:imageURL];
    }
}

- (void) clearCache
{
    [[NSFileManager defaultManager] removeItemAtPath:[self providerCacheFolderPath] error:NULL];
}

- (void) clearCacheForURL:(NSURL*)imageURL
{
    NSString *fileName = [self imageFileNameFromURL:imageURL];
    NSString *filePath = [[self providerCacheFolderPath] stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
}


@end
