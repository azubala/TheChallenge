//
//  CHLSoundCloudTableViewController.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/20/12.
//
//

#import "CHLSoundCloudTableViewController.h"

@implementation CHLSoundCloudTableViewController
@synthesize resourceURL = _resourceURL, itemsParser = _itemsParser;
@synthesize tableViewCellClass = _tableViewCellClass;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id) initWithResourceURL:(NSURL*)resourceURL itemsParser:(id<CHLSoundCloudItemParserProtocol>)parser
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _resourceURL = resourceURL;
        _itemsParser = parser;
        _tableViewCellClass = [UITableViewCell class];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//---------------------------------------------------------------------------------------------
#pragma mark - view life cycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self fetchDataSource];
}

//---------------------------------------------------------------------------------------------
#pragma mark - fetching items

- (void) fetchDataSource
{
    SCAccount *account = [SCSoundCloud account];
    if (account && _resourceURL && _itemsParser) {
        
        SCRequestResponseHandler handler;
        handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
            NSError *jsonError = nil;
            NSJSONSerialization *jsonResponse = [NSJSONSerialization
                                                 JSONObjectWithData:data
                                                 options:0
                                                 error:&jsonError];
            
            if (!jsonError && [jsonResponse isKindOfClass:[NSArray class]]) {
                _tableItems = [_itemsParser parseRawItems:(NSArray *)jsonResponse];
                [self.tableView reloadData];
            }
        };
        
        [SCRequest performMethod:SCRequestMethodGET
                      onResource:_resourceURL
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:handler];
        
    } else {
        NSLog(@"Couldn't fetch items becuase user not logged in, resource url is not specifed or there's no parser assigned");
    }
}

//---------------------------------------------------------------------------------------------
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;//[_tableItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[_tableViewCellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"Test";
    return cell;
}

@end
