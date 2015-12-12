//
//  ScalableView.m
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "ScalableView.h"
#import "BasicStaveComponent.h"

@implementation ScalableView

@synthesize scale;

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initialise];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialise];
    }
    return  self;
}

-(instancetype)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self initialise];
    }
    return self;
}

-(instancetype)initWithScale:(CGFloat)newscale{
    self = [super init];
    if (self) {
        [self initialise];
        [self setScale:newscale];
    }
    return self;
}

-(void)setScale:(CGFloat)newscale{
    scale = newscale;
    for (NSInteger i=0; i<self.subviews.count; i++) {
        id thing = [self.subviews objectAtIndex:i];
        if ([thing isKindOfClass:[ScalableView class]]) {
            [thing setScale:newscale];
        }
    }
}

-(void)initialise{
    [self setScale:10.];
}

-(void)resizeDown{
    if (self.subviews.count==0) return;
    
    CGFloat miny = MAXFLOAT;
    
    for (NSInteger i=0; i<self.subviews.count; i++) {
        NSView* view = [self.subviews objectAtIndex:i];
        CGFloat thisY = NSMinY(view.frame);
        if (thisY<miny) miny = thisY;
    }
    
    NSRect newFrame = NSMakeRect(self.frame.origin.x, self.frame.origin.y+miny, self.frame.size.width, self.frame.size.height-miny);
    [self setFrame:newFrame];
    
    for (NSInteger i=0; i<self.subviews.count; i++) {
        NSView* view = [self.subviews objectAtIndex:i];
        if ([view isKindOfClass:[BasicStaveComponent class]]) {
            BasicStaveComponent* comp = (BasicStaveComponent*)view;
            [comp setYRelativeValue:comp.yRelativeValue-miny];
        }else{
            [view setFrameOrigin:NSMakePoint(view.frame.origin.x, view.frame.origin.y-miny)];
        }
    }
}

-(void)resizeLeft{
    if (self.subviews.count==0) return;
    CGFloat minx = MAXFLOAT;
    
    for (NSInteger i=0; i<self.subviews.count; i++) {
        NSView* view = [self.subviews objectAtIndex:i];
        CGFloat thisx = NSMinX(view.frame);
        if (thisx<minx) minx = thisx;
    }
    
    NSRect newFrame = NSMakeRect(self.frame.origin.x+minx, self.frame.origin.y, self.frame.size.width-minx, self.frame.size.height);
    [self setFrame:newFrame];
    
    if (minx!=0) {
        for (NSInteger i=0; i<self.subviews.count; i++) {
            NSView* view = [self.subviews objectAtIndex:i];
            if ([view isKindOfClass:[BasicStaveComponent class]]) {
                BasicStaveComponent* comp = (BasicStaveComponent*)view;
                [comp setXValue:comp.xValue-minx];
            }else{
                [view setFrameOrigin:NSMakePoint(view.frame.origin.x-minx, view.frame.origin.y)];
            }
        }
    }
}

-(void)resizeRight{
    if (self.subviews.count==0) return;
    CGFloat maxx = 0;
    for (NSInteger i=0; i<self.subviews.count; i++) {
        NSView* view = [self.subviews objectAtIndex:i];
        CGFloat viewx = NSMaxX(view.frame);
        if (viewx>maxx) maxx = viewx;
    }
    NSSize newsize = NSMakeSize(maxx, self.frame.size.height);
    [self setFrameSize:newsize];
}


-(void)resizeUp{
    if (self.subviews.count==0) return;
    CGFloat maxY = 0;
    for (NSInteger i=0; i<self.subviews.count; i++) {
        NSView* view = [self.subviews objectAtIndex:i];
        CGFloat viewY = NSMaxY(view.frame);
        if (viewY>maxY) maxY = viewY;
    }
    NSSize newsize = NSMakeSize(self.frame.size.width, maxY);
    [self setFrameSize:newsize];
}


-(void)resizeToFit{
    [self resizeLeft];
    [self resizeDown];
    [self resizeRight];
    [self resizeUp];
}



@end
