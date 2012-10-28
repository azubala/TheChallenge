//
//  CHLUsersDataViewController.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "CHLUsersDataViewController.h"
#import "CHLTracksParser.h"
#import "CHLUsersParser.h"
#import "CHLURLFactory.h"

@implementation CHLUsersDataViewController

@dynamic usersDataView;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {

        tracksListViewController_ = [[CHLUsersTracksViewController alloc] initWithResourceURL:[[CHLURLFactory defaultFactory] userTracksURL]
                                                                                  itemsParser:[[CHLTracksParser alloc] init]];
        
        likesListViewController_ = [[CHLUsersFavoritesViewController alloc] initWithResourceURL:[[CHLURLFactory defaultFactory] userFavoritesURL]
                                                                                    itemsParser:[[CHLTracksParser alloc] init]];
        
        followingsListViewController_ = [[CHLUsersFollowingsViewController alloc] initWithResourceURL:[[CHLURLFactory defaultFactory] userFollowingsURL]
                                                                                          itemsParser:[[CHLUsersParser alloc] init]];
        
        
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - view life cycle

- (void) loadView
{
    CHLUsersDataView *usersDataView = [[CHLUsersDataView alloc] initWithFrame:CGRectZero gradientColors:@[
                                        [UIColor colorWithRed:.7f green:.7f blue:.7f alpha:1.0f],
                                        [UIColor colorWithRed:.75f green:.75f blue:.75f alpha:1.0f]
                                       ]];
    usersDataView.listsScroller.delegate = self;
    [usersDataView.listsScroller.rightButton addTarget:self action:@selector(logoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addChildViewController:likesListViewController_];
    [self addChildViewController:followingsListViewController_];
    [self addChildViewController:tracksListViewController_];
    
    usersDataView.listsScroller.viewsToScroll = @[likesListViewController_.view, followingsListViewController_.view, tracksListViewController_.view];

    [tracksListViewController_ didMoveToParentViewController:self];
    [likesListViewController_ didMoveToParentViewController:self];
    [followingsListViewController_ didMoveToParentViewController:self];
    
    self.view = usersDataView;
}

- (CHLUsersDataView*) usersDataView
{
    return [self isViewLoaded] ? (CHLUsersDataView*)self.view : nil;
}

//---------------------------------------------------------------------------------------------
#pragma mark - roations

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    CHLViewScroller *viewScroller = self.usersDataView.listsScroller;
    [viewScroller scrollToViewAtIndex:viewScroller.currentPageIndex animated:YES];
}

//---------------------------------------------------------------------------------------------
#pragma mark - CHLViewScrollerDelegate

- (NSString*) viewScroller:(CHLViewScroller *)viewScroller titleForPageAtIndex:(NSInteger)index
{
    return [self.childViewControllers[index] title];
}

//---------------------------------------------------------------------------------------------
#pragma mark - actions

- (void) logoutButtonPressed:(UIButton*)sender
{
    [SCSoundCloud removeAccess];
    [self dismissModalViewControllerAnimated:YES];
}

@end
