//
//  CHLTrackCell.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLBaseCell.h"

extern UIEdgeInsets const CHLTrackCellInsets;
extern UIOffset const CHLTrackCellOffset;
extern CGFloat const CHLTrackCellWaveFormHeight;

@interface CHLTrackCell : CHLBaseCell
{
    UILabel *dateLabel_;
    UILabel *titleLabel_;
    UILabel *artistLabel_;
    
    UIImageView *waveImageView_;
}

@property (nonatomic, readonly) UILabel *dateLabel;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *artistLabel;

@property (nonatomic, readonly) UIImageView *waveImageView;

@end
