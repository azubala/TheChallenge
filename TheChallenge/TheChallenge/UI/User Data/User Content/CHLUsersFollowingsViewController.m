//
//  CHLUsersFollowingsViewController.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLUsersFollowingsViewController.h"
#import "CHLUserObject.h"
#import "CHLImageProvider.h"

@implementation CHLUsersFollowingsViewController

- (NSString*) title
{
    return @"People you follow";
}

//---------------------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHLBaseCell *cell = (CHLBaseCell*)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CHLUserObject *userObject = [_tableItems objectAtIndex:indexPath.row];
    cell.textLabel.text = userObject.username;
    cell.currentModelObject = userObject;
    
    [[CHLImageProvider defaultProvider] imageWithURL:userObject.avatarURL scale:1.0f crop:NO completionBlock:^(BOOL success, UIImage *image) {
        if (success && cell.currentModelObject == userObject) {
            cell.imageView.image = image;
            [cell setNeedsDisplay];
            [cell setNeedsLayout];
        }
    }];
    
    return cell;
}

@end
