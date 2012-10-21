//
//  CHLRootViewController.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

/**
 Designed as a root view controller of the app, manages loggining in and switching between acounts
 **/

#import <UIKit/UIKit.h>
#import "CHLRootView.h"

@interface CHLRootViewController : UIViewController

@property (nonatomic, readonly) CHLRootView *rootView; //dynamic getter based on self.view, so weak referenced

@end
