//
//  CHLTrackCell.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLTrackCell.h"
#import "UILabel+MeasuringTextHelpers.h"

UIEdgeInsets const CHLTrackCellInsets = {.top = 10.0f, .left = 10.0f, .bottom = 10.0f, .right = 10.0f};
UIOffset const CHLTrackCellOffset = {.horizontal = 0.0f, .vertical = 5.0f};

CGFloat const CHLTrackCellWaveFormHeight = 50.0f;

@implementation CHLTrackCell
@synthesize dateLabel = dateLabel_, titleLabel = titleLabel_, artistLabel = artistLabel_;
@synthesize waveImageView = waveImageView_;

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        dateLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
        [self basicSetupForLabel:dateLabel_ textFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor grayColor]];
        [self.contentView addSubview:dateLabel_];
        
        titleLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
        [self basicSetupForLabel:titleLabel_ textFont:[UIFont boldSystemFontOfSize:20.0f] textColor:[UIColor blackColor]];
        [self.contentView addSubview:titleLabel_];
        
        artistLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
        [self basicSetupForLabel:artistLabel_ textFont:[UIFont boldSystemFontOfSize:14.0f] textColor:[UIColor orangeColor]];
        [self.contentView addSubview:artistLabel_];
        
        waveImageView_ = [[UIImageView alloc] initWithFrame:CGRectZero];
        waveImageView_.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:waveImageView_];
        
    }
    return self;
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    waveImageView_.image = nil;
    waveImageView_.backgroundColor = [UIColor clearColor];
}

//---------------------------------------------------------------------------------------------
#pragma mark - layouts & drawing

- (void) layoutSubviews
{
    [super layoutSubviews];
    UIEdgeInsets insets = CHLTrackCellInsets;
    UIOffset offset = CHLTrackCellOffset;
    CGRect availableRect = UIEdgeInsetsInsetRect(self.contentView.bounds, insets);
    CGSize viewSize = availableRect.size;
    CGPoint pos = availableRect.origin;
    
    CGSize labelSize = [dateLabel_ sizeOfLabelConstrainedToSize:viewSize];
    dateLabel_.frame = CGRectMake(pos.x, pos.y, labelSize.width, labelSize.height);
    pos.y += labelSize.height + offset.vertical;
    viewSize.height -= labelSize.height + offset.vertical;
    
    labelSize = [titleLabel_ sizeOfLabelConstrainedToSize:viewSize];
    titleLabel_.frame = CGRectMake(pos.x, pos.y, labelSize.width, labelSize.height);
    pos.y += labelSize.height + offset.vertical;
    viewSize.height -= labelSize.height + offset.vertical;

    labelSize = [artistLabel_ sizeOfLabelConstrainedToSize:viewSize];
    artistLabel_.frame = CGRectMake(pos.x, pos.y, labelSize.width, labelSize.height);
    pos.y += labelSize.height + offset.vertical;
    viewSize.height -= labelSize.height + offset.vertical;
    
    CGSize waveSize = CGSizeMake(viewSize.width, CHLTrackCellWaveFormHeight);
    waveImageView_.frame = CGRectMake(pos.x, pos.y, waveSize.width, waveSize.height);
    
}

//---------------------------------------------------------------------------------------------
#pragma mark - view setup

- (void) basicSetupForLabel:(UILabel*)label textFont:(UIFont*)font textColor:(UIColor*)color
{
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.textColor = color;
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
}

- (CGFloat) centerFactorForDimension:(CGFloat)aDim constrainedToDimension:(CGFloat)aConstrainedDim
{
    return floor((aConstrainedDim - aDim)/2);
}



@end
