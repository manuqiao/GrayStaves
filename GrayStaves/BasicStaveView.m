//
//  BasicStaveView.m
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveView.h"
#import "BasicStaveComponent.h"
#import "GrayStavesDelegate.h"

@implementation BasicStaveView
@synthesize staveInsets;

-(void)initialise{
    [super initialise];
    [self setStaveInsets:MakeStaveInsets(30, 30, 0, 0)];
}

- (void)drawRect:(NSRect)dirtyRect {    
    [super drawRect:dirtyRect];
    NSBezierPath* path = [NSBezierPath bezierPathWithRect:dirtyRect];
    [path setLineDash:nil count:50 phase:.5];
    [path stroke];
}

- (void)setStaveInsets:(StaveInsets)newinsets{
    staveInsets = newinsets;
    [self refreshLayout];
}

-(void)setStaveInsetsTop:(CGFloat)top{
    staveInsets.top = top;
    [self refreshLayout];
}

-(void)setStaveInsetBottom:(CGFloat)bottom{
    staveInsets.bottom = bottom;
    [self refreshLayout];
}

-(void)setStaveInsetRight:(CGFloat)right{
    staveInsets.right = right;
    [self refreshLayout];
}

-(void)setStaveInsetLeft:(CGFloat)left{
    staveInsets.left = left;
    [self refreshLayout];
}

-(void)setScale:(CGFloat)scale{
    [super setScale:scale];
    [self refreshLayout];
}



-(void)refreshLayout{
    for (NSInteger i=0; i<self.subviews.count; i++) {
        NSView* subview = [self.subviews objectAtIndex:i];
        if ([subview isKindOfClass:[BasicStaveView class]]) {
            BasicStaveView* bsview = (BasicStaveView*)subview;
            [subview setFrameOrigin:NSMakePoint(subview.frame.origin.x, self.staveInsets.bottom-bsview.staveInsets.bottom)];
        }else if ([subview isKindOfClass:[BasicStaveComponent class]]){
            BasicStaveComponent* bscomp = (BasicStaveComponent*)subview;
            [bscomp setYRelativeValue:bscomp.yRelativeValue];
        }
    }
    [self setNeedsDisplay:YES];
}


-(void)addSubview:(ScalableView *)aView{
    if (aView.scale!=self.scale){
        [aView setScale:self.scale];
    }
    [super addSubview:aView];
}

-(void)mouseDown:(NSEvent *)theEvent{
    NSPoint point = [theEvent locationInWindow];
    NSPoint thisOrigin = self.frame.origin;
    NSPoint mousePoint = NSMakePoint(point.x-thisOrigin.x, point.y-thisOrigin.y);
    CGFloat mouseHeight = mousePoint.y;
    NoteStruct note = [GrayStavesDelegate noteForHeight:mouseHeight givenRelativeNote:MakeNoteStruct(Note_F, 0) atHeight:self.staveInsets.bottom andScale:self.scale];
}



@end
