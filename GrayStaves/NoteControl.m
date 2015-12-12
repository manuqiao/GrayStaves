//
//  NoteControl.m
//  GrayStaves
//
//  Created by Thomas Gray on 29/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteControl.h"

@implementation NoteControl

@synthesize noteStruct;
@synthesize modifier;
@synthesize timeValue;

//@synthesize scale;

@synthesize noteComponent;
@synthesize noteTailComponent;
@synthesize accidental;

//@synthesize xValue;
//@synthesize relativeYValue;

@synthesize tailUp;
@synthesize dotted;
@synthesize drawFlag;

-(void)initialise{
    tailUp = YES;
    drawFlag = YES;
}

-(instancetype)initWithScale:(CGFloat)scle{
    self = [super initWithScale:scle];
    if (self) {
        noteComponent = [[NoteHeadComponent alloc]initWithScale:scle];
    }
    return self;
}

-(instancetype)initWithScale:(CGFloat)scle note:(NoteStruct)nte timeValue:(NoteTimeValue)tval andModifier:(NoteModifier)mod{
    self = [super initWithScale:scle];
    if (self) {
        noteComponent = [[NoteHeadComponent alloc]initWithScale:self.scale];
        [self setNoteStruct:nte];
        [self setTimeValue:tval];
        [self setModifier:mod];
    }
    return self;
}

-(void)setNoteStruct:(NoteStruct)newNote{
    noteStruct = newNote;
    [noteComponent setNote:newNote];
}

-(void)setTimeValue:(NoteTimeValue)newtime{
    timeValue = newtime;
    [noteComponent setTimeValue:newtime];
    if (timeValue==TimeValue_Whole){
        noteTailComponent = nil;
    }else if (noteTailComponent){
        [noteTailComponent setTimeValue:timeValue];
    }else{
        noteTailComponent = [[NoteTailComponent alloc]initWithScale:self.scale andTimeValue:timeValue];
        [noteTailComponent setTailUp:tailUp];
    }
}

-(void)setModifier:(NoteModifier)newMod{
    modifier = newMod;
    if (modifier==NoteModifierNone) {
        accidental = nil;
    }else if (accidental){
        [accidental setModifier:modifier];
    }else{
        accidental = [[AccidentalComponent alloc]initWithScale:self.scale andModifier:modifier];
    }
}

-(void)setTailUp:(BOOL)newVal{
    tailUp = newVal;
    if (noteTailComponent) {
        [noteTailComponent setTailUp:tailUp];
    }
}

-(void)setDrawFlag:(BOOL)newVal{
    drawFlag = newVal;
    if (noteTailComponent) {
        [noteTailComponent setDrawFlags:drawFlag];
    }
}

-(void)setYrelativeValue:(CGFloat)newY{
    [super setYrelativeValue:newY];
    [noteComponent setYRelativeValue:newY];
    if (accidental) {
        [accidental setYRelativeValue:newY];
    }
    if (noteTailComponent) {
        if (noteTailComponent.tailUp) {
            [noteTailComponent setYRelativeValue:newY+(self.scale*.66)];
        }else{
            [noteTailComponent setYRelativeValue:newY+(self.scale*.33)];
        }
    }
}

-(void)setXRelativeValue:(CGFloat)newX{
    [super setXRelativeValue:newX];
    [noteComponent setXValue:newX];
    if (accidental) {
        
    }
    if (noteTailComponent) {
        if (noteTailComponent.tailUp) {
            [noteTailComponent setXValue:(newX+noteComponent.frame.size.width*.98)-[noteTailComponent stemWidth]];
        }else{
            [noteTailComponent setXValue:newX+(.02*noteComponent.frame.size.width)];
        }
    }
}


-(void)addToStave:(BasicStaveView*)stave{
    [stave addSubview:noteComponent];
    if (accidental){
        [stave addSubview:accidental];
    }
    if (noteTailComponent) {
        [stave addSubview:noteTailComponent];
    }
}

-(void)removeFromSuperview{
    [noteComponent removeFromSuperview];
    if (accidental) [accidental removeFromSuperview];
    if (noteTailComponent)[noteTailComponent removeFromSuperview];
}


@end
