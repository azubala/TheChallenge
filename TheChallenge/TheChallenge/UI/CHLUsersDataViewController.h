//
//  CHLUsersDataViewController.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import <UIKit/UIKit.h>
#import "CHLUsersDataView.h"
#import "CHLSoundCloudTableViewController.h"

@interface CHLUsersDataViewController : UIViewController
{
    CHLSoundCloudTableViewController *tracksListViewController_;
    CHLSoundCloudTableViewController *likesListViewController_;
    CHLSoundCloudTableViewController *proposalsListViewController_;
}

@property (nonatomic, readonly) CHLUsersDataView *usersDataView; //dynamic getter based on self.view, so weak referenced

@end
