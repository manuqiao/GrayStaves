//
//  BasicStaveComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"
#import "BasicStaveView.h"

@implementation BasicStaveComponent

@synthesize xValue;
@synthesize yRelativeValue;

-(void)initialise{
    [super initialise];
}

-(void)setXValue:(CGFloat)newxValue{
    xValue = newxValue;
    CGFloat realX = [self xValueTransform:xValue];
    [self setFrameOrigin:NSMakePoint(realX, self.frame.origin.y)];
}

-(void)setYRelativeValue:(CGFloat)newY{
    yRelativeValue = newY;
    CGFloat realY = [self YValueTransform:newY];
    [self setFrameOrigin:NSMakePoint(self.frame.origin.x, realY)];
}

-(void)setFrameOriginAtRelativePoint:(NSPoint)newOrigin{
    CGFloat newX = [self xValueTransform:newOrigin.x];
    CGFloat newY = [self YValueTransform:newOrigin.y];
    [self setFrameOrigin:NSMakePoint(newX, newY)];
}

-(void)setFrameOriginAtRelativeXValue:(CGFloat)x andYValue:(CGFloat)y{
    xValue = x;
    CGFloat realX = [self xValueTransform:x];
    yRelativeValue = y;
    CGFloat realy = [self YValueTransform:y];
    [self setFrameOrigin:NSMakePoint(realX, realy)];
}

-(CGFloat)xValueTransform:(CGFloat)literalX{
    return literalX;
}

-(CGFloat)YValueTransform:(CGFloat)literalY{
    return literalY;
}



@end
