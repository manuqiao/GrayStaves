//
//  NoteHeadComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 03/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteHeadComponent.h"
#import "GrayStavesDelegate.h"
#import "StaveMetrics.h"

@interface NoteHeadComponent ()

+(CGFloat)scaleRatioOfTailStart;

@end

@implementation NoteHeadComponent

@synthesize note;
@synthesize timeValue;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}


-(instancetype)initWithScale:(CGFloat)scale note:(NoteStruct)nte andTimeValue:(NoteTimeValue)timeVal{
    self = [super initWithScale:scale];
    if (self) {
        [self setNote:nte];
        [self setTimeValue:timeVal];
    }
    return self;
}

+(instancetype)note:(NoteStruct)nte withTimeValue:(NoteTimeValue)tmeval andScale:(CGFloat)scle{
    NoteHeadComponent* out = [[NoteHeadComponent alloc]initWithScale:scle note:nte andTimeValue:tmeval];
    return out;
}


-(void)setNote:(NoteStruct)nte{
    note = nte;
}

-(void)setTimeValue:(NoteTimeValue)newtimeValue{
    timeValue = newtimeValue;
    NSImage* image;
    if (timeValue==TimeValue_Whole) {
        image = [GrayStavesDelegate getImageNamed:@"1-note"];
    }else if (timeValue==TimeValue_Half){
        image = [GrayStavesDelegate getImageNamed:@"2-note-head"];
    }else{
        image = [GrayStavesDelegate getImageNamed:@"4-note-head"];
    }
    CGFloat ratio = image.size.width/image.size.height;
    NSSize thisSize = NSMakeSize(ratio*self.scale, self.scale);
    [image setSize:thisSize];
    [self setFrameSize:thisSize];
    [self setImage:image];
}


+(CGFloat)scaleRatioOfTailStart{
    return .65;
}

+(CGFloat)widthRatio{
    return 131./105.;
}

-(void)setFrameOrigin:(NSPoint)newOrigin{
    [super setFrameOrigin:newOrigin];
}


@end
