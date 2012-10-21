//
//  CHLUsersDataView.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import <UIKit/UIKit.h>
#import "CHLViewScroller.h"

@interface CHLUsersDataView : UIView
{
    CHLViewScroller *_listsScroller;
    UIPageControl *_pageControl;
    UIButton *_logoutButton;
}

@property (nonatomic, readonly) CHLViewScroller *listsScroller;
@property (nonatomic, readonly) UIPageControl *pageControl;
@property (nonatomic, readonly) UIButton *logoutButton;


@end
