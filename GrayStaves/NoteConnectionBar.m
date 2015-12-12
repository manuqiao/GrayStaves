//
//  NoteConnectionBar.m
//  GrayStaves
//
//  Created by Thomas Gray on 08/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteConnectionBar.h"
#import "StaveMetrics.h"

#define _barThicknessRatio .5

@interface NoteConnectionBar()
@end


@implementation NoteConnectionBar
@synthesize inclined;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    CGFloat thickness = _barThicknessRatio*self.scale;
    NSPoint topLeft = inclined? NSMakePoint(0, thickness):NSMakePoint(0, dirtyRect.size.height);
    NSPoint topRight = inclined? NSMakePoint(dirtyRect.size.width, dirtyRect.size.height):NSMakePoint(dirtyRect.size.width, thickness);
    
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path moveToPoint:topLeft];
    [path lineToPoint:NSMakePoint(topLeft.x, topLeft.y-thickness)];
    [path lineToPoint:NSMakePoint(topRight.x, topRight.y-thickness)];
    [path lineToPoint:topRight];
    [path closePath];
    
    NSColor* col = self.color? self.color: [NSColor blackColor];
    [col setFill];
    [path fill];
}

-(void)positionLeftPoint:(NSPoint)lpoint rightPoint:(NSPoint)rPoint{
    NSPoint leftPoint;
    NSPoint rightPoint;
    if (lpoint.x<=rPoint.x) {
        leftPoint = lpoint;
        rightPoint = rPoint;
    }else{
        leftPoint = rPoint;
        rightPoint = lpoint;
    }
    
    if (leftPoint.y<=rightPoint.y) {
        inclined = TRUE;
    }else inclined = FALSE;
    
    CGFloat thickness = self.scale*_barThicknessRatio;
    
    CGFloat frameY = leftPoint.y<=rightPoint.y? leftPoint.y:rightPoint.y;
    CGFloat frameX = leftPoint.x;
    CGFloat frameWidth = rightPoint.x-leftPoint.x;
    CGFloat frameHeight = inclined? (rightPoint.y-leftPoint.y)+thickness:(leftPoint.y-rightPoint.y)+thickness;
    [self setFrameSize:NSMakeSize(frameWidth, frameHeight)];
    [self setFrameOriginAtRelativeXValue:frameX andYValue:frameY];
}

@end
