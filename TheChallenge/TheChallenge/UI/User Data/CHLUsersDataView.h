//
//  CHLUsersDataView.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import <UIKit/UIKit.h>
#import "CHLViewScroller.h"
#import "CHLGradientView.h"

@interface CHLUsersDataView : CHLGradientView
{
    CHLViewScroller *_listsScroller;
    UIButton *_logoutButton;
}

@property (nonatomic, readonly) CHLViewScroller *listsScroller;
@property (nonatomic, readonly) UIButton *logoutButton;


@end
