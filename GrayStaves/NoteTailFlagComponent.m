//
//  NoteTailFlagComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 11/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteTailFlagComponent.h"
#import "GrayStavesDelegate.h"
#import "StaveMetrics.h"

@implementation NoteTailFlagComponent

@synthesize timeValue;
@synthesize drawUpward;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(instancetype)initWithScale:(CGFloat)scale andTimeVale:(TimeValue)tval drawingUpward:(BOOL)up{
    self = [super initWithScale:scale];
    if (self) {
        drawUpward = up;
        [self setTimeValue:tval];
    }
    return self;
}

-(void)setTimeValue:(TimeValue)tval{
    timeValue = tval;
   
    NSString* imageName;
    switch (timeValue) {
        case TimeValue_8th:
            imageName = @"8-note-flag";
            break;
        case TimeValue_16th:
            imageName = @"16-note-flag";
            break;
        case TimeValue_32nd:
            imageName = @"32-note-flag";
            break;
        case TimeValue_64th:
            imageName = @"64-note-flag";
            break;
        default:
            [self setImage:nil];
            return;
    }
    NSImage* image = [GrayStavesDelegate getImageNamed:imageName];
    if (!drawUpward) {
        NSImage* flippedImage = [[NSImage alloc]initWithSize:image.size];
        [flippedImage lockFocus];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        NSAffineTransform* transform = [NSAffineTransform transform];
        [transform translateXBy:0 yBy:flippedImage.size.height];
        [transform scaleXBy:1 yBy:-1];
        [transform concat];
        [image drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0, flippedImage.size.width, flippedImage.size.height) operation:NSCompositeSourceOver fraction:1.f];
        [flippedImage unlockFocus];
        image = flippedImage;
    }
    [self setImage:image];
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat widthHeightRatio = height/width;
    CGFloat newWidth = self.scale*_NoteTailFlagWidthScale;
    CGFloat newHeight = newWidth*widthHeightRatio;
    [self setFrameSize:NSMakeSize(newWidth, newHeight)];
}

-(void)setDrawUpward:(BOOL)up{
    if (up==drawUpward) return;
    drawUpward = up;
    [self setTimeValue:timeValue];
}

-(CGFloat)xValueTransform:(CGFloat)literalX{
    return literalX-1.;
}

@end
