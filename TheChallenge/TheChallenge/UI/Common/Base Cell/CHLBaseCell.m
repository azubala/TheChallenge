//
//  CHLBaseCell.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLBaseCell.h"
#import "CHLGradientView.h"

@implementation CHLBaseCell
@synthesize currentModelObject = currentModelObject_;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundView = [[CHLGradientView alloc] initWithFrame:CGRectZero gradientColors:@[
                                    [UIColor colorWithRed:.8f green:.8f blue:.8f alpha:1.0f],
                                    [UIColor colorWithRed:.9f green:.9f blue:.9f alpha:1.0f]
                               ]];
        
        self.selectedBackgroundView = [[CHLGradientView alloc] initWithFrame:CGRectZero gradientColors:@[
                                           [UIColor colorWithRed:.3f green:.3f blue:.3f alpha:1.0f],
                                           [UIColor colorWithRed:.2f green:.2f blue:.2f alpha:1.0f]
                                       ]];
        
        self.textLabel.numberOfLines = 0;
        self.textLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:15.0f];
        
    }
    return self;
}


//---------------------------------------------------------------------------------------------
#pragma mark - layouts & drawing

@end
