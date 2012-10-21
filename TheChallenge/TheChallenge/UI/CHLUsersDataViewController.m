//
//  CHLUsersDataViewController.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "CHLUsersDataViewController.h"

@implementation CHLUsersDataViewController
@dynamic usersDataView;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        tracksListViewController_ = [[CHLSoundCloudTableViewController alloc] initWithResourceURL:nil itemsParser:nil];
        likesListViewController_ = [[CHLSoundCloudTableViewController alloc] initWithResourceURL:nil itemsParser:nil];;
        proposalsListViewController_ = [[CHLSoundCloudTableViewController alloc] initWithResourceURL:nil itemsParser:nil];;
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - view life cycle

- (void) loadView
{
    CHLUsersDataView *usersDataView = [[CHLUsersDataView alloc] initWithFrame:CGRectZero];
    
    [self addChildViewController:tracksListViewController_];
    [self addChildViewController:likesListViewController_];
    [self addChildViewController:proposalsListViewController_];
    
    usersDataView.listsScroller.viewsToScroll = @[tracksListViewController_.view, likesListViewController_.view, proposalsListViewController_.view];

    [tracksListViewController_ didMoveToParentViewController:self];
    [likesListViewController_ didMoveToParentViewController:self];
    [proposalsListViewController_ didMoveToParentViewController:self];
    
    self.view = usersDataView;
}

- (CHLUsersDataView*) usersDataView
{
    return [self isViewLoaded] ? (CHLUsersDataView*)self.view : nil;
}

@end
