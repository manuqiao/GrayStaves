//
//  KeySignatureControl.m
//  GrayStaves
//
//  Created by Thomas Gray on 30/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "KeySignatureControl.h"
#import "GrayStavesDelegate.h"

@interface KeySignatureControl ()

-(void)matchAccidentalNotesToClef;
//-(void)

@end

//------
@implementation KeySignatureControl

@synthesize clef;
@synthesize keySignature;
@synthesize accidentals;

-(instancetype)initWithScale:(CGFloat)scle clef:(ClefEnum)clf andKeySignature:(KeySignature)sig{
    self = [super initWithScale:scle];
    if (self) {
        clef = clf;
        [self setKeySignature:sig];
    }
    return self;
}

-(void)initialise{
    [super initialise];
    accidentals = [[NSMutableArray alloc]init];
}

-(void)setClef:(ClefEnum)newclef{
    clef = newclef;
    [self matchAccidentalNotesToClef];
}

-(void)setScale:(CGFloat)scale{
    [super setScale:scale];
    for (NSInteger i=0; i<accidentals.count; i++) {
        AccidentalComponent* comp = [accidentals objectAtIndex:i];
        [comp setScale:scale];
    }
    [self setYrelativeValue:self.YrelativeValue];
}

-(void)setKeySignature:(KeySignature)newkeySignature{
    [accidentals removeAllObjects];
    keySignature = newkeySignature;
    if (keySignature==0) {
        return;
    }else if (keySignature<0){
        for (int i=-1; i>=keySignature; i--) {
            NoteLetter letter = [KeySignatureControl noteLetterForKeyIndex:i];
            AccidentalComponent* accidental = [[AccidentalComponent alloc]initWithScale:self.scale andModifier:NoteModifierFlat];
            NoteStruct note = MakeNoteStruct(letter, 0);
            [accidental setNote:note];
            [accidentals addObject:accidental];
        }
    }else{
        for (int i=1; i<=keySignature; i++) {
            NoteLetter letter = [KeySignatureControl noteLetterForKeyIndex:i];
            AccidentalComponent* accidental = [[AccidentalComponent alloc]initWithScale:self.scale andModifier:NoteModifierSharp];
            NoteStruct note = MakeNoteStruct(letter, 0);
            [accidental setNote:note];
            [accidentals addObject:accidental];
        }
    }
    [self matchAccidentalNotesToClef];
}

-(void)addToStave:(BasicStaveView *)stave{
    for (NSInteger i=0; i<accidentals.count; i++) {
        [stave addSubview:[accidentals objectAtIndex:i]];
    }
    [self setYrelativeValue:stave.staveInsets.bottom];
}

-(void)matchAccidentalNotesToClef{
    for (NSInteger i=0; i<accidentals.count; i++) {
        AccidentalComponent* accidental = [accidentals objectAtIndex:i];
        NoteStruct note = accidental.note;
    here:;
        CGFloat height = [GrayStavesDelegate heightForNote:note givenRelativeNote:[GrayStavesDelegate baseNoteForStaveClef:clef] atHeight:0 andScale:self.scale];
        if (height<0) {
            note.index++;
            goto here;
        }else if (height>3.*self.scale){
            note.index--;
            goto here;
        }
        [accidental setNote:note];
    }
}

-(void)setXRelativeValue:(CGFloat)xRelativeValue{
    [super setXRelativeValue:xRelativeValue];
    [self setYrelativeValue:self.YrelativeValue];
}

-(void)setYrelativeValue:(CGFloat)YrelativeValue{
    [super setYrelativeValue:YrelativeValue];
    NoteStruct relativeNote = [GrayStavesDelegate baseNoteForStaveClef:clef];
    CGFloat startingX = self.xRelativeValue;
    CGFloat relHeight = self.YrelativeValue;
    for (NSInteger i=0; i<accidentals.count; i++) {
        AccidentalComponent* comp = [accidentals objectAtIndex:i];
        CGFloat thisx = startingX + (i*1.2*comp.frame.size.width);
        CGFloat thisY = [GrayStavesDelegate heightForNote:comp.note givenRelativeNote:relativeNote atHeight:relHeight andScale:self.scale];
        [comp setFrameOriginAtRelativeXValue:thisx andYValue:thisY];
    }
}

-(void)removeFromSuperview{
    for (NSInteger i=0; i<accidentals.count; i++) {
        AccidentalComponent* comp = [accidentals objectAtIndex:i];
        [comp removeFromSuperview];
    }
}

+(NoteLetter)noteLetterForKeyIndex:(KeySignature)sig{
    switch (sig) {
        case 1: return Note_F;
        case 2: return Note_C;
        case 3: return Note_G;
        case 4: return Note_D;
        case 5: return Note_A;
        case 6: return Note_E;
        case 7: return Note_B;
        case -1: return Note_B;
        case -2: return Note_E;
        case -3: return Note_A;
        case -4: return Note_D;
        case -5: return Note_G;
        case -6: return Note_C;
        case -7: return Note_F;
            
        default: @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"No note for this index" userInfo:@{@"Index":[NSString stringWithFormat:@"%d", sig]}];
    }
}

@end
