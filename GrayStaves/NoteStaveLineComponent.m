//
//  NoteStaveLineComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 08/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteStaveLineComponent.h"
#import "NoteHeadComponent.h"
#import "StaveMetrics.h"

@implementation NoteStaveLineComponent

@synthesize lineCount;
@synthesize lineColor;
@synthesize drawUpwards;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    CGFloat start = self.scale/2.;
    if (!drawUpwards) {
        start = dirtyRect.size.height-start;
    }
    for (NSInteger i=0; i<=lineCount; i++) {
        CGFloat thisLineHeight;
        if (drawUpwards) {
            thisLineHeight = start + (i*self.scale);
        }else{
            thisLineHeight = start - (i*self.scale);
        }
        NSBezierPath* path = [NSBezierPath bezierPath];
        NSColor* col = lineColor? lineColor:[NSColor blackColor];
        [col setStroke];
        [path moveToPoint:NSMakePoint(0, thisLineHeight)];
        [path lineToPoint:NSMakePoint(dirtyRect.size.width, thisLineHeight)];
        [path stroke];
    }
//    [[NSBezierPath bezierPathWithRect:dirtyRect]stroke];
}

-(CGFloat)YValueTransform:(CGFloat)literalY{
    if (drawUpwards) {
        return literalY-(self.scale/2.);
    }else{
        return literalY-self.frame.size.height+(self.scale/2.);
    }
}

-(CGFloat)xValueTransform:(CGFloat)literalX{
    return literalX-(self.scale*_NoteStaveLineExcessRatio);
}

-(void)setLineCount:(int)count{
    lineCount = count;
    CGFloat noteWidth = self.scale*[NoteHeadComponent widthRatio];
    [self setFrameSize:NSMakeSize((self.scale*2*_NoteStaveLineExcessRatio)+noteWidth, self.scale*lineCount)];
}


@end
