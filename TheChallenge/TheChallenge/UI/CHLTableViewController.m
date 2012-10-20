//
//  CHLTableViewController.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/20/12.
//
//

#import "CHLTableViewController.h"
#import "SCUI.h"
#import "SCAPI.h"

@implementation CHLTableViewController
{
    NSArray *tracks_;
}

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//---------------------------------------------------------------------------------------------
#pragma mark - view life cycle

- (void) loadView
{
    [super loadView];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    SCAccount *account = [SCSoundCloud account];
    if (!account) {
        NSLog(@"Need to login");
        
        SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
            if (SC_CANCELED(error)) {
                NSLog(@"Canceled!");
            } else if (error) {
                NSLog(@"Error: %@", [error localizedDescription]);
            } else {
                NSLog(@"Done!");
                [self fetchTracks];
            }
        };

        [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
            SCLoginViewController *loginViewController;

            loginViewController = [SCLoginViewController
                                   loginViewControllerWithPreparedURL:preparedURL
                                   completionHandler:handler];
            [self presentModalViewController:loginViewController animated:YES];
        }];
    } else {
        [self fetchTracks];
    }
}

- (void) fetchTracks
{
    SCAccount *account = [SCSoundCloud account];
    if (account) {
        
        SCRequestResponseHandler handler;
        handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
            NSError *jsonError = nil;
            NSJSONSerialization *jsonResponse = [NSJSONSerialization
                                                 JSONObjectWithData:data
                                                 options:0
                                                 error:&jsonError];
            
            if (!jsonError && [jsonResponse isKindOfClass:[NSArray class]]) {
                tracks_ = (NSArray *)jsonResponse;
                NSLog(@"Fetched tracks:%@",tracks_);
                [self.tableView reloadData];
            }
        };
        
        NSString *resourceURL = @"https://api.soundcloud.com/me/favorites.json";
        [SCRequest performMethod:SCRequestMethodGET
                      onResource:[NSURL URLWithString:resourceURL]
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:handler];
        
    }
}

//---------------------------------------------------------------------------------------------
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tracks_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[tracks_ objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

//---------------------------------------------------------------------------------------------
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
