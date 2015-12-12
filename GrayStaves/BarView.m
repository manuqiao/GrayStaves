//
//  BarView.m
//  GrayStaves
//
//  Created by Thomas Gray on 22/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BarView.h"
#import "GrayStavesDelegate.h"

@implementation BarView

@synthesize clef;
@synthesize timeSignature;
@synthesize keySignature;

@synthesize drawClef;
@synthesize drawTimeSignature;
@synthesize drawKeySignature;

@synthesize clefView;
@synthesize keySignatureControl;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(instancetype)initWithScale:(CGFloat)scale Clef:(ClefEnum)clf Key:(KeySignature)key andTimeSignature:(TimeSignature)tme{
    self = [super initWithScale:scale];
    if (self) {
        clef = clf;
        keySignature = key;
        timeSignature = tme;
    }
    return self;
}

-(void)setDrawClef:(BOOL)draw{
    if (drawClef == draw) return;
    drawClef = draw;
    if (draw) {
        clefView = [[ClefComponent alloc]initWithClef:self.clef andScale:self.scale];
        [self addSubview:clefView];
        [clefView setFrameOriginAtRelativeXValue:self.staveInsets.left andYValue:self.staveInsets.bottom];
    }else if (clefView){
        [clefView removeFromSuperview];
        clefView = nil;
    }
    [self setNeedsDisplay:YES];
}

-(void)setDrawKeySignature:(BOOL)draw{
    if (drawKeySignature==draw) return;
    drawKeySignature = draw;
    if (drawKeySignature) {
        keySignatureControl = [[KeySignatureControl alloc]initWithScale:self.scale clef:self.clef andKeySignature:self.keySignature];
        CGFloat keySigX=self.staveInsets.left;
        if (drawClef) {
            keySigX+=clefView.frame.size.width+(self.scale/2.);
        }
        [keySignatureControl setXRelativeValue:keySigX];
        [keySignatureControl addToStave:self];
    }else if (keySignature){
        [keySignatureControl removeFromSuperview];
        keySignatureControl = nil;
    }
}

-(void)setClef:(ClefEnum)newclef{
    clef = newclef;
}

-(void)setTimeSignature:(TimeSignature)newts{
    timeSignature = newts;
}

-(void)setKeySignature:(KeySignature)keySig{
    keySignature = keySig;
}

-(NoteStruct)noteAtPoint:(CGFloat)pnt{
    NoteStruct out;
    
    return out;
}

-(CGFloat)heightForNote:(NoteStruct)nte{
    return [GrayStavesDelegate heightForNote:nte givenRelativeNote:[GrayStavesDelegate baseNoteForStaveClef:self.clef] atHeight:self.staveInsets.bottom andScale:self.scale];
}

-(void)setStaveInsets:(StaveInsets)staveInsets{
    StaveInsets oldInsets = self.staveInsets;
    [super setStaveInsets:staveInsets];
    CGFloat leftShift = self.staveInsets.left-oldInsets.left;
    if (clefView) {
        [clefView setYRelativeValue:staveInsets.bottom];
        if (leftShift!=0) [clefView setXValue:clefView.xValue+leftShift];
    }
    if (keySignatureControl) {
        [keySignatureControl setYrelativeValue:staveInsets.bottom];
        if (leftShift!=0) [keySignatureControl setXRelativeValue:keySignatureControl.xRelativeValue+leftShift];
    }
}

-(void)addComponent:(BasicStaveComponent *)comp{
    [self addSubview:comp];
    if ([comp isKindOfClass:[BasicNoteComponent class]]) {
        BasicNoteComponent* note = (BasicNoteComponent*)comp;
        [comp setYRelativeValue:[self heightForNote:note.noteStruct]];
        
    }else{
        [comp setYRelativeValue:self.staveInsets.bottom];
    }
}

-(void)addComponent:(BasicStaveComponent *)comp atX:(CGFloat)xval{
    [self addComponent:comp];
    [comp setXValue:xval];
}

@end
