//
//  CHLViewScroller.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import <UIKit/UIKit.h>

@interface CHLViewScroller : UIScrollView
{
    NSArray *_viewsToScroll;
}

@property (nonatomic, strong) NSArray *viewsToScroll; //dynamic setter


@end
