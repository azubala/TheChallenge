//
//  CHLRootView.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

/**
 Custom view for root view controller.
 **/

#import <UIKit/UIKit.h>

@interface CHLRootView : UIView
{
    UIActivityIndicatorView *_spinner;
    UILabel *_infoLabel;
    UIButton *_loginButton;
}

@property (nonatomic, readonly) UIActivityIndicatorView *spinner;
@property (nonatomic, readonly) UILabel *infoLabel;
@property (nonatomic, readonly) UIButton *loginButton;

@end
