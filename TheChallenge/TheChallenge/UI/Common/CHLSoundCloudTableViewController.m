//
//  CHLSoundCloudTableViewController.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/20/12.
//
//

#import "CHLSoundCloudTableViewController.h"
#import "CHLGradientView.h"

@implementation CHLSoundCloudTableViewController
@synthesize resourceURL = _resourceURL, itemsParser = _itemsParser;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id) initWithResourceURL:(NSURL*)resourceURL itemsParser:(id<CHLSoundCloudItemParserProtocol>)parser
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _resourceURL = resourceURL;
        _itemsParser = parser;
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundView = [[CHLGradientView alloc] initWithFrame:CGRectZero gradientColors:@[
                                        [UIColor colorWithRed:.7f green:.7f blue:.7f alpha:1.0f],
                                        [UIColor colorWithRed:.75f green:.75f blue:.75f alpha:1.0f]
                                     ]];
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
    return [_tableItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CHLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CHLBaseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    return cell;
}

//---------------------------------------------------------------------------------------------
#pragma mark - table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

@end
