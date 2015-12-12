//
//  StaveView.m
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "StaveView.h"

@implementation StaveView

@synthesize staveLineColor;
@synthesize backgroundColor;

-(void)initialise{
    [super initialise];
    staveLineColor = [NSColor blackColor];
    backgroundColor = [NSColor whiteColor];
}

- (void)drawRect:(NSRect)dirtyRect {
    if (backgroundColor) {
        [backgroundColor setFill];
        [[NSBezierPath bezierPathWithRect:dirtyRect]fill];
    }
    [super drawRect:dirtyRect];
    CGFloat left = self.staveInsets.left;
    CGFloat right = self.frame.size.width-self.staveInsets.right;
    [staveLineColor setStroke];
    for (int i=0; i<5; i++) {
        CGFloat y = self.staveInsets.bottom+(i*self.scale);
        NSBezierPath* line = [[NSBezierPath alloc]init];
        [line setLineWidth:1.];
        [line moveToPoint:NSMakePoint(left, y)];
        [line lineToPoint:NSMakePoint(right, y)];
        [line stroke];
    }
}

-(void)setStaveLineColor:(NSColor *)newstaveLineColor{
    staveLineColor = newstaveLineColor;
    [self setNeedsDisplay:YES];
}

-(void)addBar:(BarView *)bar atX:(CGFloat)xpos{
    if (bar.staveInsets.bottom!=self.staveInsets.bottom) {
        [bar setStaveInsetBottom:self.staveInsets.bottom];
        [bar setStaveInsetsTop:self.staveInsets.top];
    }
    [bar setFrameOrigin:NSMakePoint(xpos, self.staveInsets.bottom-bar.staveInsets.bottom)];
    [self addSubview:bar];
}



@end
