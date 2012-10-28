//
//  UILabel+MeasuringTextHelpers.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import "UILabel+MeasuringTextHelpers.h"

@implementation UILabel (MeasuringTextHelpers)

- (CGSize) sizeOfLabelConstrainedToSize:(CGSize)constrainedSize
{
    CGSize labelSize = CGSizeZero;
    if (self.text) {
        labelSize = [self.text sizeWithFont:self.font constrainedToSize:constrainedSize lineBreakMode:self.lineBreakMode];
    }
    return labelSize;
}

@end
