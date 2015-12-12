//
//  NoteConnection.m
//  GrayStaves
//
//  Created by Thomas Gray on 08/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteConnection.h"

#define _barScaleRatio .5
#define _barScaleSepatationRatio = .2

@interface NoteConnection ()

-(NSPoint)leftPoint;
-(NSPoint)rightPoint;

@end

@implementation NoteConnection

@synthesize notes;
@synthesize timeValue;

@synthesize yRightmostValue;
@synthesize xRightmostValue;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)initialise{
    [super initialise];
    notes = [[NSMutableArray alloc]init];
}

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval{
    self = [super initWithScale:scale];
    if (self) {
        [self setTimeValue:tval];
    }
    return self;
}

-(void)addNotes:(NoteComponent *)note, ...{
    va_list args;
    va_start(args, note);
    
    NoteComponent* arg = nil;
    while ((arg=va_arg(args, NoteComponent*))) {
        [notes addObject:arg];
    }
}

-(void)removeNotes:(NoteComponent *)note, ...{
    va_list args;
    va_start(args, note);
    
    NoteComponent* arg = nil;
    while ((arg=va_arg(args, NoteComponent*))) {
        [notes removeObject:arg];
    }
}

-(NSPoint)leftPoint{
    NoteComponent* leftmostNote = nil;
    for (NSInteger i=0; i<notes.count; i++) {
        NoteComponent* note = [notes objectAtIndex:i];
        if (leftmostNote){
            if (note.xValue < leftmostNote.xValue) {
                leftmostNote = note;
            }
        }else{
            leftmostNote = note;
        }
    }
    if (leftmostNote) {
        return NSMakePoint(0, 0);
    }else return NSMakePoint(0, 0);
}

-(void)align{
    if (!notes.count) return;
    BOOL tailUp = [notes objectAtIndex:0].tailUp;
    if (tailUp) {
        
    }else{
        
    }
}

-(void)setXRightmostValue:(CGFloat)newX{
    xRightmostValue = newX;
    [self setFrameSize:NSMakeSize(xRightmostValue-self.xValue, self.frame.size.height)];
}

-(void)setYRightmostValue:(CGFloat)newY{
    yRightmostValue = newY;
    [self setFrameSize:NSMakeSize(self.frame.size.height, 10)];
}

@end
