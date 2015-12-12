//
//  NoteTailComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 29/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteTailComponent.h"
#import "GrayStavesDelegate.h"
#import "StaveMetrics.h"

@interface NoteTailComponent ()

-(void)refreshLayout;

@end

@implementation NoteTailComponent

@synthesize flagComponent;
@synthesize timeValue;
@synthesize tailLengthScale;
@synthesize tailUp;
@synthesize drawFlags;
@synthesize autoSize;

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval{
    self = [super initWithScale:scale];
    if (self) {
        [self setTimeValue:tval];
    }
    return self;
}

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval tailUp:(BOOL)up{
    self = [super initWithScale:scale];
    if (self) {
        tailUp = up;
        [self setTimeValue:tval];
    }
    return self;
}

-(void)initialise{
    [super initialise];
    tailUp = true;
    tailLengthScale = _NoteTailDefaultLength;
    drawFlags = TRUE;
    autoSize = TRUE;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    CGFloat leftX=0;

    NSRect rect = NSMakeRect(leftX, 0, (self.scale*_NoteTailWidthScale), dirtyRect.size.height);
    NSBezierPath * path = [NSBezierPath bezierPathWithRect:rect];
    NSColor* col = self.color? self.color:[NSColor blackColor];
    [col setFill];
    [path fill];
}

//-(void)setScale:(CGFloat)scale{
//    [super setScale:scale];
//}

-(void)setTimeValue:(NoteTimeValue)newTimeVal{
    timeValue = newTimeVal;
    if (drawFlags && timeValue>4) {
        if (!flagComponent) {
            flagComponent = [[NoteTailFlagComponent alloc]initWithScale:self.scale];
            [self addSubview:flagComponent];
        }
        [flagComponent setDrawUpward:tailUp];
        [flagComponent setTimeValue:timeValue];
    }else{
        if (flagComponent) {
            [flagComponent removeFromSuperview];
            flagComponent = nil;
        }
    }
    [self refreshLayout];
}

-(void)refreshLayout{
    NSSize size;
    if (drawFlags && flagComponent) {
        CGFloat recommendedScaleLength;
        switch (timeValue) {
            case TimeValue_8th:
                recommendedScaleLength = 3.;
                break;
            case TimeValue_16th:
                recommendedScaleLength = 3.5;
                break;
            case TimeValue_32nd:
                recommendedScaleLength = 4.;
                break;
            case TimeValue_64th:
                recommendedScaleLength = 4.5;
                break;
            default:
                return;
        }
        CGFloat height;
        if (autoSize) {
            height = self.scale*recommendedScaleLength;
        }else{
            height = self.scale*tailLengthScale;
        }
        size = NSMakeSize(self.scale*_NoteTailWidthScale+flagComponent.frame.size.width, height);
        
        if (tailUp) {
            CGFloat flagY = self.frame.size.height - flagComponent.frame.size.height;
            [flagComponent setFrameOriginAtRelativeXValue:(self.scale*_NoteTailWidthScale) andYValue:flagY];
        }else{
            [flagComponent setFrameOriginAtRelativeXValue:self.scale*_NoteTailWidthScale andYValue:0];
        }
    }else{
        size = NSMakeSize(self.scale*_NoteTailWidthScale, self.scale*tailLengthScale);
    }
    [self setFrameSize:size];
}

-(void)setTailLengthScale:(CGFloat)newVal{
    tailLengthScale = newVal;
    [self refreshLayout];
}

-(void)setTailUp:(BOOL)newVal{
    if (tailUp !=newVal){
        tailUp = newVal;
        [self setTimeValue:timeValue];
    }
}

-(void)setDrawFlags:(BOOL)newVal{
    if (newVal!=drawFlags) {
        drawFlags = newVal;
        [self setTimeValue:timeValue];
    }
}

-(CGFloat)YValueTransform:(CGFloat)literalY{
    if (tailUp) {
        return literalY;
    }else{
        return literalY-self.frame.size.height;
    }
}
//-(CGFloat)xValueTransform:(CGFloat)literalX{
//    if (tailUp) {
//        return literalX+self.frame.size.width;
//    }else{
//        return literalX;
//    }
//}

-(CGFloat)stemWidth{
    return self.scale*_NoteTailWidthScale;
}

-(void)setTailExtent:(CGFloat)bottomHeight to:(CGFloat)topHeight{
    CGFloat bottom;
    CGFloat top;
    if (bottomHeight<=topHeight) {
        bottom = bottomHeight;
        top = topHeight;
    }else{
        bottom = topHeight;
        top = bottomHeight;
    }
    CGFloat diff = top-bottom;
    CGFloat ratio = diff/self.scale;
    [self setTailLengthScale:ratio];
    if (tailUp) {
        [self setYRelativeValue:bottom];
    }else [self setYRelativeValue:top];
}


@end
