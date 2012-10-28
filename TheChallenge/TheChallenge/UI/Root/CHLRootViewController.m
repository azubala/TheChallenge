//
//  CHLRootViewController.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "CHLRootViewController.h"
#import "CHLUsersDataViewController.h"

@implementation CHLRootViewController
@dynamic rootView;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - view life cycle

- (void) loadView
{
    CHLRootView *rootView = [[CHLRootView alloc] initWithFrame:CGRectZero gradientColors:@[
                                [UIColor colorWithRed:.7f green:.7f blue:.7f alpha:1.0f],
                                [UIColor colorWithRed:.75f green:.75f blue:.75f alpha:1.0f]
                             ]];
    [rootView.spinner  startAnimating];
    self.view = rootView;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if ([SCSoundCloud account]) {
        [self presentUsersDataViewController];
    } else {
        [self presentLoginViewController];
    }

}

- (CHLRootView*) rootView
{
    return [self isViewLoaded] ? (CHLRootView*)self.view : nil;
}

//---------------------------------------------------------------------------------------------
#pragma mark - view controllers presenting

- (void) presentLoginViewController
{
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Canceled!");
        } else if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            [self presentUsersDataViewController];
        }
    };
    
    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
        SCLoginViewController *loginViewController;
        
        loginViewController = [SCLoginViewController
                               loginViewControllerWithPreparedURL:preparedURL
                               completionHandler:handler];
        [self presentModalViewController:loginViewController animated:YES];
    }];
}

- (void) presentUsersDataViewController
{
    CHLUsersDataViewController *usersDataViewController = [[CHLUsersDataViewController alloc] init];
    usersDataViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:usersDataViewController animated:YES];
}

@end
