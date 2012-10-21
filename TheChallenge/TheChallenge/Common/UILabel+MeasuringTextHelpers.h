//
//  UILabel+MeasuringTextHelpers.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/21/12.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (MeasuringTextHelpers)

- (CGSize) sizeOfLabel:(UILabel*)aLabel constrainedToSize:(CGSize)constrainedSize;

@end
