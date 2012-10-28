//
//  CHLGradientView.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLGradientView.h"

@implementation CHLGradientView
{
    NSArray *_colorsList;
}

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithFrame:(CGRect)frame gradientColors:(NSArray*)colorsList
{
    self = [super initWithFrame:frame];
    if (self) {
        _colorsList = colorsList;
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - layouts & drawing

- (void) drawRect:(CGRect)rect
{
    // draw gradient
    
    NSInteger numOfColors = [_colorsList count];
    if (!numOfColors && numOfColors == 1) {
        NSLog(@"Too few colors for gradient!");
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSInteger numOfComponents = 4;
    CGFloat components[numOfColors*numOfComponents];
    CGFloat locations[numOfColors];
    CGFloat locationDelta = 1.0f/(numOfColors-1);
    
    for (NSInteger i=0; i<numOfColors; i++) {
        locations[i] = i*locationDelta;
        UIColor *aColor = [_colorsList objectAtIndex:i];
        const CGFloat* colorComponents = CGColorGetComponents(aColor.CGColor);
        for (NSInteger j=0; j<numOfComponents; j++) {
            components[i*numOfComponents+j] = colorComponents[j];
        }
    }
    
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, numOfColors);
    
    CGPoint startPoint, endPoint;
    [self startPoint:&startPoint endPoint:&endPoint inRect:rect forAngle:M_PI withOffset:0.0f];
    CGContextDrawLinearGradient(context, myGradient, startPoint, endPoint, 0);
    
    CGColorSpaceRelease(myColorspace);
    CGGradientRelease(myGradient);
    
    //draw upper lines
    [[UIColor colorWithRed:.0f green:.0f blue:.0f alpha:.3f] setStroke];
    CGPoint pos = CGPointMake(0.0f, 0.5f);
    CGContextMoveToPoint(context, pos.x, pos.y);
    pos.x += rect.size.width;
    CGContextAddLineToPoint(context, pos.x, pos.y);
    CGContextStrokePath(context);
    
    [[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:.5f] setStroke];
    pos = CGPointMake(0.0f, 1.5f);
    CGContextMoveToPoint(context, pos.x, pos.y);
    pos.x += rect.size.width;
    CGContextAddLineToPoint(context, pos.x, pos.y);
    CGContextStrokePath(context);
}

- (void) startPoint:(CGPoint*)aStartPtr endPoint:(CGPoint*)aEndPtr inRect:(CGRect)rect forAngle:(CGFloat)aAngle withOffset:(CGFloat)offset
{
    *aStartPtr= rect.origin;
    *aEndPtr= CGPointMake((*aStartPtr).x, CGRectGetMaxY(rect));
}

@end
