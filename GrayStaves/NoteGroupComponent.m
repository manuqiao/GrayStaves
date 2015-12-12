//
//  NoteGroupComponent.m
//  GrayStaves
//
//  Created by Thomas Gray on 09/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "NoteGroupComponent.h"
#import "StaveMetrics.h"

@interface NoteGroupComponent ()

-(void)privateAddNote:(NoteComponent*)note;
-(void)privateRemoveNote:(NoteComponent*)note;

-(void)alignNotes;
-(void)alignTail;
-(void)sortNotesArray:(BOOL)ascending;

@end

@implementation NoteGroupComponent

@synthesize notes;
@synthesize mainTail;
@synthesize connectingTail;

-(void)initialise{
    [super initialise];
    notes = [[NSMutableArray alloc]init];
    [super setTailUp:YES];
    [super setDrawTail:YES];
    [super setDrawFlag:YES];
}

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval tailUp:(BOOL)up{
    self  = [super initWithScale:scale];
    if (self) {
        [super setTailUp:up];
        [super setTimeValue:tval];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];    
}

-(void)addNote:(NoteStruct)note  withModifier:(NoteModifier)mod{
    NoteComponent* noteComp = [[NoteComponent alloc]initWithScale:self.scale note:note timeValue:self.timeValue andModifier:mod];
    [self privateAddNote:noteComp];
}

-(void)addNotes:(NoteComponent *)note, ...{
    va_list args;
    va_start(args, note);
    
    NoteComponent* arg = nil;
    for (arg = note; arg!=nil; arg=va_arg(args, NoteComponent*)) {
        [self privateAddNote:arg];
    }
}

-(void)privateAddNote:(NoteComponent *)note{
    if (![note isMemberOfClass:[NoteComponent class]]) return;
    [notes addObject:note];
    [self sortNotesArray:YES];
    [note setDrawTail:NO];
    [note setFrameOriginAtRelativeXValue:0 andYValue:0];
    [self addSubview:note];
    [self alignNotes];
    [self alignTail];
    [self resizeToFit];
    [self setNoteStruct:[notes objectAtIndex:0].noteStruct];
}

-(void)removeNotes:(NoteComponent *)note, ...{
    va_list args;
    va_start(args, note);
    
    NoteComponent* arg = nil;
    for (arg=note; arg!=nil; arg=va_arg(args, NoteComponent*)) {
        [self privateRemoveNote:arg];
    }    
}

-(void)privateRemoveNote:(NoteComponent *)note{
    [note removeFromSuperview];
    [notes removeObject:note];
    [self alignNotes];
    [self resizeToFit];
}


-(void)alignNotes{
    if (notes.count==0)return;
    [notes.firstObject setModifierRight:!self.tailUp];
    NoteComponent* bottomNote;
    CGFloat bottomX;
    CGFloat bottomY;
    BOOL setOff = FALSE;
    
    for (NSInteger i=1; i<notes.count; i++) {
        bottomNote = [notes objectAtIndex:i-1];
        bottomX = bottomNote.xValue;
        bottomY = bottomNote.yRelativeValue;
        NoteComponent* nextNote = [notes objectAtIndex:i];
        
        NSInteger separation = 0;
        NoteStruct nextNoteStr = nextNote.noteStruct;
        while (nextNoteStr.index!=bottomNote.noteStruct.index || nextNoteStr.letter!=bottomNote.noteStruct.letter) {
            nextNoteStr = ScalePrevioustNoteStruct(nextNoteStr);
            separation++;
        }
        if (separation==1) {
            setOff = !setOff;
            [nextNote setModifierRight:(setOff==self.tailUp)];
        }else{
            setOff=FALSE;
            [nextNote setModifierRight:!self.tailUp];
        }
        
        CGFloat thisY = bottomY+ (separation*self.scale/2.);
        
        CGFloat thisX;
        if (setOff) {
            if (self.tailUp) {
                thisX = bottomNote.xValue+bottomNote.noteComponent.frame.size.width-(self.scale*_NoteTailWidthScale);
            }else{
                thisX =bottomNote.xValue-nextNote.noteComponent.frame.size.width+(self.scale*_NoteTailWidthScale);
            }
        }else{
            thisX = bottomNote.xValue;
        }
        [nextNote setFrameOriginAtRelativeXValue:thisX andYValue:thisY];
    }
}

-(void)setTailUp:(BOOL)tailUp{
    if (self.tailUp==tailUp)return;
    [super setTailUp:tailUp];
    if (self.mainTail) {
        [mainTail setTailUp:tailUp];
    }
    [self alignTail];
}

-(void)setTimeValue:(NoteTimeValue)newVal{
    [super setTimeValue:newVal];
    for (NSInteger i=0; i<notes.count; i++) {
        NoteComponent* comp = [notes objectAtIndex:i];
        [comp setTimeValue:newVal];
    }
    if (!self.drawTail) {
        if (mainTail) [mainTail removeFromSuperview];
        if (connectingTail) [connectingTail removeFromSuperview];
        mainTail = nil;
        connectingTail = nil;
        [self resizeToFit];
        return;
    }
    if (!mainTail) {
        mainTail= [[NoteTailComponent alloc]initWithScale:self.scale andTimeValue:self.timeValue];
        [mainTail setDrawFlags:self.drawFlag];
        [self addSubview:mainTail];
    }
    if (!connectingTail || notes.count<2) {
        connectingTail = [[NoteTailComponent alloc]initWithScale:self.scale andTimeValue:self.timeValue];
        [connectingTail setDrawFlags:NO];
    }else if (notes.count<2){
        [connectingTail removeFromSuperview];
        connectingTail = nil;
    }
    [self alignTail];
    [self resizeToFit];
}

-(void)setDrawTail:(BOOL)drawTail{
    [super setDrawTail:drawTail];
}

-(void)setDrawFlag:(BOOL)drawFlag{
    if (self.drawFlag==drawFlag) return;
    [super setDrawFlag:drawFlag];
    [mainTail setDrawFlags:self.drawFlag];
    if (self.drawFlag) {
        [self setTimeValue:self.timeValue];
    }
    
}

-(void)alignTail{
    if (notes.count==0 || !self.drawTail){
        if (mainTail) {
            [mainTail removeFromSuperview];
            mainTail = nil;
        }
        if (connectingTail) {
            [connectingTail removeFromSuperview];
            connectingTail = nil;
        }
        return;
    }
    if (!mainTail) {
        mainTail = [[NoteTailComponent alloc]initWithScale:self.scale andTimeValue:self.timeValue tailUp:self.tailUp];
        [self addSubview:mainTail];
    }
    [mainTail setTimeValue:self.timeValue];
    [mainTail setTailUp:self.tailUp];
    [mainTail setDrawFlags:self.drawFlag];
    
    
    NoteComponent* bottomNote = notes.firstObject;
    NoteComponent* topNote = notes.lastObject;
    NSRect bottomNoteHeadFrame = bottomNote.noteComponent.frame;
    bottomNoteHeadFrame = NSMakeRect(bottomNote.frame.origin.x+bottomNoteHeadFrame.origin.y, bottomNote.frame.origin.y+bottomNoteHeadFrame.origin.y, bottomNoteHeadFrame.size.width, bottomNoteHeadFrame.size.height);
    NSRect topNoteHeadFrame = topNote.noteComponent.frame;
    topNoteHeadFrame = NSMakeRect(topNote.frame.origin.x+topNoteHeadFrame.origin.x, topNote.frame.origin.y+topNoteHeadFrame.origin.y, topNoteHeadFrame.size.width, topNoteHeadFrame.size.height);
    
    if (bottomNote==topNote) {
        if (connectingTail) [connectingTail removeFromSuperview];
        connectingTail = nil;
    }else{
        if (!connectingTail){
            connectingTail = [[NoteTailComponent alloc]initWithScale:self.scale];
            [connectingTail setDrawFlags:NO];
            [connectingTail setAutoSize:NO];
            [self addSubview:connectingTail];
        }
        CGFloat connectingBottom;
        CGFloat connectingTop;
        CGFloat connectingX;
        
        if (self.tailUp) {
            connectingX = bottomNoteHeadFrame.origin.x+bottomNoteHeadFrame.size.width-connectingTail.stemWidth;
            connectingBottom = bottomNoteHeadFrame.origin.y+self.scale*_NoteHeadTailConnectionRight;
            connectingTop = topNoteHeadFrame.origin.y;
            if (topNote.xValue>bottomNote.xValue) {
                connectingTop+=self.scale*_NoteHeadTailConnectionLeft;
            }else connectingTop+=self.scale*_NoteHeadTailConnectionRight;
        }else{
            connectingX = bottomNoteHeadFrame.origin.x;
            connectingBottom = bottomNoteHeadFrame.origin.y+self.scale*_NoteHeadTailConnectionLeft;
            connectingTop = topNoteHeadFrame.origin.y;
            if (topNote.xValue<bottomNote.xValue) {
                connectingTop+=self.scale*_NoteHeadTailConnectionRight;
            }else connectingTop+=self.scale*_NoteHeadTailConnectionLeft;
        }
        [connectingTail setXValue:connectingX];
        [connectingTail setTailExtent:connectingBottom to:connectingTop];
    }
    CGFloat mainX;
    CGFloat mainY;
    if (self.tailUp) {
        mainX = bottomNoteHeadFrame.origin.x+bottomNoteHeadFrame.size.width-mainTail.stemWidth;
        mainY = topNoteHeadFrame.origin.y+self.scale*_NoteHeadTailConnectionRight;
    }else{
        mainX = bottomNoteHeadFrame.origin.x;
        mainY = bottomNoteHeadFrame.origin.y+self.scale*_NoteHeadTailConnectionLeft;
    }
    [mainTail setFrameOriginAtRelativeXValue:mainX andYValue:mainY];
}

-(CGFloat)xValueTransform:(CGFloat)literalX{
    if (notes.count) {
        NoteComponent* comp = [notes objectAtIndex:0];
        return literalX-comp.frame.origin.x-comp.noteComponent.frame.origin.x;
    }else{
        return literalX;
    }
}

-(CGFloat)YValueTransform:(CGFloat)literalY{
    if (notes.count) {
        NoteComponent* comp = [notes objectAtIndex:0];
        return literalY-comp.frame.origin.y-comp.noteComponent.frame.origin.y;
    }else return literalY;
}

-(void)sortNotesArray:(BOOL)ascending{
    if (ascending) {
        [notes sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NoteComponent* n1 = (NoteComponent*)obj1;
            NoteComponent* n2 = (NoteComponent*)obj2;
            return CompareNotes(n1.noteStruct, n2.noteStruct);
        }];
    }else{
        [notes sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NoteComponent* n1 = (NoteComponent*)obj1;
            NoteComponent* n2 = (NoteComponent*)obj2;
            NSComparisonResult out = CompareNotes(n1.noteStruct, n2.noteStruct);
            if (out==NSOrderedSame) return out;
            else if (out==NSOrderedAscending) return NSOrderedDescending;
            else return NSOrderedAscending;
        }];
    }
}

@end
