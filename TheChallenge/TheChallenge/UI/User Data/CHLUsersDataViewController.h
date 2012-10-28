//
//  CHLUsersDataViewController.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import <UIKit/UIKit.h>
#import "CHLUsersDataView.h"
#import "CHLUsersFavoritesViewController.h"
#import "CHLUsersFollowingsViewController.h"
#import "CHLUsersTracksViewController.h"

@interface CHLUsersDataViewController : UIViewController <CHLViewScrollerDelegate>
{
    CHLUsersTracksViewController *tracksListViewController_;
    CHLUsersFavoritesViewController *likesListViewController_;
    CHLUsersFollowingsViewController *followingsListViewController_;
}

@property (nonatomic, readonly) CHLUsersDataView *usersDataView; //dynamic getter based on self.view, so weak referenced

@end
