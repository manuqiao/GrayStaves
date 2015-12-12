//
//  RestComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 02/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "RestComponent.h"
#import "GrayStavesDelegate.h"

@interface RestComponent ()

-(void)resize;

@end


@implementation RestComponent

@synthesize timeValue;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval{
    self = [super initWithScale:scale];
    if (self) {
        [self setTimeValue:tval];
    }
    return self;
}

-(void)setTimeValue:(NoteTimeValue)newtimeValue{
    timeValue = newtimeValue;
    NSImage * image;
    switch (timeValue) {
        case TimeValue_Whole: case TimeValue_Half:
            image = [GrayStavesDelegate getImageNamed:@"1-2-rest"];
            break;
        case TimeValue_Quarter:
            image = [GrayStavesDelegate getImageNamed:@"4-rest"];
            break;
        case TimeValue_8th:
            image = [GrayStavesDelegate getImageNamed:@"8-rest"];
            break;
        case TimeValue_16th:
            image = [GrayStavesDelegate getImageNamed:@"16-rest"];
            break;
        case TimeValue_32nd:
            image = [GrayStavesDelegate getImageNamed:@"32-rest"];
            break;
        case TimeValue_64th:
            image = [GrayStavesDelegate getImageNamed:@"64-rest"];
            break;
        default:
            return;
    }
    [self setImage:image];
    [self resize];
}

-(void)setScale:(CGFloat)scale{
    [super setScale:scale];
    [self resize];
}

-(void)resize{
    CGFloat ratio = self.image.size.width/self.image.size.height;
    CGFloat heightTransform;
    CGFloat newHeight;
    NSSize newSize;
    switch (timeValue) {
        case TimeValue_Whole:
        case TimeValue_Half:
            heightTransform = .5;
            break;
        case TimeValue_Quarter:
            heightTransform = 3.;
            break;
        case TimeValue_8th:
            heightTransform = 2.;
            break;
        case TimeValue_16th:
            heightTransform = 3.;
            break;
        case TimeValue_32nd:
            heightTransform = 4.;
            break;
        case TimeValue_64th:
            heightTransform = 5.;
            break;
        default:
            break;
    }
    newHeight = self.scale*heightTransform;
    newSize = NSMakeSize(newHeight*ratio, newHeight);
    [self.image setSize:newSize];
    [self setFrameSize:newSize];
}

-(CGFloat)YValueTransform:(CGFloat)literalY{
    CGFloat scale = self.scale;
    switch (timeValue) {
        case TimeValue_Whole:
            return literalY+scale*2.5;
        case TimeValue_Half:
            return literalY+scale*2.;
        case TimeValue_Quarter:
            return literalY+scale*.5;
        case TimeValue_8th:
            return literalY+scale;
        case TimeValue_16th: case TimeValue_32nd:
            return literalY;
        case TimeValue_64th:
            return literalY-scale;
        default:
            return 0;
    }
}

@end
