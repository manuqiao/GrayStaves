//
//  NoteComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 26/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteComponent.h"
//#import "NoteComponent(Protected).h"
#import "GrayStavesDelegate.h"


#define __accidentalScaleSeparation .2

@interface NoteComponent ()

-(void)alignTail;
-(void)alignDot;
-(void)alignAccidental;

@end


@implementation NoteComponent

@synthesize noteComponent;
@synthesize noteTailComponent;
@synthesize accidental;
@synthesize staveLine;

@synthesize noteStruct;
@synthesize timeValue;
@synthesize modifier;

@synthesize dotted;
//@synthesize tailUp;
//@synthesize drawFlag;
@synthesize modifierRight;
//@synthesize drawTail;


-(void)drawRect:(NSRect)dirtyRect{
    //[[NSBezierPath bezierPathWithRect:dirtyRect] stroke];
}

-(void)initialise{
    [super initialise];
    [super setDrawFlag:TRUE];
    [super setTailUp:TRUE];
    modifierRight = FALSE;
    dotted = FALSE;
    [super setDrawTail:TRUE];
}


-(instancetype)initWithScale:(CGFloat)scle note:(NoteStruct)nte timeValue:(NoteTimeValue)tval andModifier:(NoteModifier)mod{
    self = [super initWithScale:scle];
    if (self) {
        [self setNoteStruct:nte];
        [self setTimeValue:tval];
        [self setModifier:mod];
    }
    return self;
}


-(void)setNoteStruct:(NoteStruct)newNote{
    noteStruct = newNote;
}


-(void)setTimeValue:(NoteTimeValue)newVal{
    timeValue = newVal;
    if (!noteComponent){
        noteComponent = [[NoteHeadComponent alloc]initWithScale:self.scale note:noteStruct andTimeValue:timeValue];
        [self addSubview:noteComponent];
        [noteComponent setFrameOrigin:NSMakePoint(0, 0)];
    }else{
        [noteComponent setTimeValue:timeValue];
    }
    if (timeValue>TimeValue_Whole && self.drawTail) {
        if (noteTailComponent) [noteTailComponent setTimeValue:timeValue];
        else{
            noteTailComponent = [[NoteTailComponent alloc]initWithScale:self.scale andTimeValue:timeValue];
            [noteTailComponent setDrawFlags:self.drawFlag];
            [noteTailComponent setTailUp:self.tailUp];
            [self addSubview:noteTailComponent];
        }
        [self alignTail];
        [self resizeToFit];
    }else{
        if (noteTailComponent) {
            [noteTailComponent removeFromSuperview];
            noteTailComponent = nil;
        }else{
            
        }
    }
}

-(void)setModifier:(NoteModifier)newModifier{
    modifier = newModifier;
    if (modifier!=NoteModifierNone) {
        if (accidental) {
            [accidental setModifier:modifier];
        }else{
            accidental = [[AccidentalComponent alloc]initWithScale:self.scale andModifier:modifier];
            [self addSubview:accidental];
        }
        [self alignAccidental];
        [self resizeToFit];
    }else{
        if (accidental) [accidental removeFromSuperview];
        accidental = nil;
        [self resizeToFit];
    }
}

-(void)setModifierRight:(BOOL)newVal{
    if (modifierRight != newVal) {
        modifierRight=newVal;
        [self alignAccidental];
        [self resizeToFit];
    }
}

-(void)setDotted:(BOOL)newVal{
    dotted = newVal;
}

-(void)setTailUp:(BOOL)newtailUp{
    [super setTailUp:newtailUp];
    if (noteTailComponent) {
        [noteTailComponent setTailUp:self.tailUp];
        [self alignTail];
        [self resizeToFit];
    }
}

-(void)setDrawFlag:(BOOL)newdrawFlag{
    [super setDrawFlag:newdrawFlag];
    if (noteTailComponent) {
        [noteTailComponent setDrawFlags:self.drawFlag];
        [self alignTail];
        [self resizeToFit];
    }
}

-(CGFloat)xValueTransform:(CGFloat)literalX{
    return literalX-noteComponent.frame.origin.x;
}

-(CGFloat)YValueTransform:(CGFloat)literalY{
    CGFloat diff = noteComponent.frame.origin.y;
    return literalY-diff;
}


-(void)setDrawTail:(BOOL)val{
    if (self.drawTail==val) return;
    [super setDrawTail:val];
    if (self.drawTail) {
        if (!noteTailComponent) {
            noteTailComponent = [[NoteTailComponent alloc]initWithScale:self.scale andTimeValue:timeValue];
            [self alignTail];
            [self resizeToFit];
        }
    }else{
        if (noteTailComponent) {
            [noteTailComponent removeFromSuperview];
            noteTailComponent = nil;
            [self resizeToFit];
        }
    }
}

-(void)alignTail{
    if (![self.subviews containsObject:noteComponent]) return;
    if (![self.subviews containsObject:noteTailComponent] && self.timeValue>TimeValue_Whole) {
        [self addSubview:noteTailComponent];
    }else if (timeValue==TimeValue_Whole){
        if ([self.subviews containsObject:noteTailComponent]) [noteTailComponent removeFromSuperview];
        return;
    }
    
    CGFloat noteX = noteComponent.frame.origin.x;
    CGFloat noteY = noteComponent.frame.origin.y;
    CGFloat relTailX;
    CGFloat relTailY;
    
    if (self.tailUp) {
        relTailX = noteX+noteComponent.frame.size.width-noteTailComponent.stemWidth;
        relTailY = noteY+self.scale*0.5;
    }else{
        relTailX = noteX;
        relTailY = noteY+self.scale*.33;
    }
    [noteTailComponent setXValue:relTailX];
    [noteTailComponent setYRelativeValue:relTailY];
}

-(void)alignDot{
    
}

-(void)alignAccidental{
    if (!accidental) return;
    if (!noteComponent) return;
    
    if (![self.subviews containsObject:accidental]) {
        [self addSubview:accidental];
    }
    
    CGFloat accidentalY = noteComponent.yRelativeValue;
    CGFloat accidentalX;
    
    if (modifierRight) {
        accidentalX = noteComponent.xValue+noteComponent.frame.size.width+(self.scale*__accidentalScaleSeparation);
    }else{
        accidentalX = noteComponent.xValue-(self.scale*__accidentalScaleSeparation)-accidental.frame.size.width;
    }
    [accidental setFrameOriginAtRelativeXValue:accidentalX andYValue:accidentalY];
}

-(void)setBackingLinesVisible:(BOOL)vis withLineNumber:(int)number drawingUpwards:(BOOL)drawup onNote:(BOOL)on{
    if (!noteComponent) return;
    CGFloat lineX;
    CGFloat lineY;
    if (vis) {
        if (!staveLine){
            staveLine = [[NoteStaveLineComponent alloc]initWithScale:self.scale];
            [self addSubview:staveLine positioned:NSWindowBelow relativeTo:noteComponent];
        }
        lineX = noteComponent.xValue;
        [staveLine setDrawUpwards:drawup];
        [staveLine setLineCount:number];
    }else{
        if (staveLine) [staveLine removeFromSuperview];
        staveLine = nil;
        [self resizeToFit];
        return;
    }
    if (on) {
        lineY = noteComponent.yRelativeValue+self.scale*.5;
    }else{
        if (drawup) {
            lineY = noteComponent.yRelativeValue+noteComponent.frame.size.height;
        }else{
            lineY = noteComponent.yRelativeValue;
        }
    }
    [staveLine setFrameOriginAtRelativeXValue:lineX andYValue:lineY];
    [self resizeToFit];
}

-(NSPoint)tailTipPoint:(BOOL)front{
    NSPoint thisO = self.frame.origin;
    CGFloat tailx = front? noteTailComponent.frame.origin.x:noteTailComponent.frame.origin.x+noteTailComponent.stemWidth;
    CGFloat taily;
    if (self.tailUp) {
        taily = noteTailComponent.frame.origin.y+noteTailComponent.frame.size.height;
    }else{
        taily = noteTailComponent.frame.origin.y;
    }
    return NSMakePoint(thisO.x+tailx, thisO.y+taily);
}


@end
