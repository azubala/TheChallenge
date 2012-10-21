//
//  CHLSoundCloudTableViewController.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/20/12.
//
//

/**
 Table view controller with fetching data from SoundCloud API, parsing mechanism and generic cell
 **/

#import <UIKit/UIKit.h>
#import "CHLSoundCloudItemParserProtocol.h"

@interface CHLSoundCloudTableViewController : UITableViewController
{
    NSURL *_resourceURL;
    id <CHLSoundCloudItemParserProtocol> _itemsParser;
    
    NSArray *_tableItems;
    Class _tableViewCellClass;
}

@property (nonatomic, readonly)  NSURL *resourceURL;
@property (nonatomic, readonly) id <CHLSoundCloudItemParserProtocol> itemsParser;

@property (nonatomic) Class tableViewCellClass; // default is UITableViewCell, have to a subclass of that class, if not fallback to default

// initializers
- (id) initWithResourceURL:(NSURL*)resourceURL itemsParser:(id<CHLSoundCloudItemParserProtocol>)parser;

@end
