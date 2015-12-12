//
//  StaveConstants.h
//  GrayStaves
//
//  Created by Thomas Gray on 21/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#ifndef StaveConstants_h
#define StaveConstants_h

typedef enum _clef {
    ClefBass, ClefTenor, ClefAlto, ClefTreble
} ClefEnum;

typedef enum _NoteModifier {
    NoteModifierSharp, NoteModifierFlat, NoteModifierNatural, NoteModifierNone
} NoteModifier;

typedef NS_ENUM(int, NoteTimeValue){
    TimeValue_Whole = 1, TimeValue_Half = 2, TimeValue_Quarter = 4, TimeValue_8th = 8, TimeValue_16th = 16, TimeValue_32nd = 32, TimeValue_64th = 64
};


typedef int NoteIndex;

typedef NS_ENUM(int, NoteLetter) {
    Note_A=0, Note_B=1, Note_C=2, Note_D=3, Note_E=4, Note_F=5, Note_G=6
};

typedef struct _timeSignature{
    NSInteger numerator; NSInteger denominator;
} TimeSignature;

typedef NS_ENUM(int, KeySignature){
    Key_CM = 0, Key_Am = 0,
    Key_GM = 1, Key_Em = 1,
    Key_DM = 2, Key_Bm = 2,
    Key_AM = 3, Key_Fsm = 3,
    Key_EM = 4, Key_Csm = 4,
    Key_BM = 5, Key_Gsm = 5,
    Key_FsM = 6, Key_Dsm = 6,
    Key_CsM = 7, Key_Asm = 7,
    
    Key_FM = -1, Key_Dm = -1,
    Key_BbM = -2, Key_Gm = -2,
    Key_EbM = -3, Key_Cm = -3,
    Key_AbM = -4, Key_Fm = -4,
    Key_DbM = -5, Key_Bbm = -5,
    Key_GbM = -6, Key_Ebm = -6,
    Key_CbM = -7, Key_Abm = -7
};

typedef struct _NoteStruct {
    NoteLetter letter;
    NoteIndex index;
} NoteStruct;

NS_INLINE NoteStruct MakeNoteStruct(NoteLetter letter, NoteIndex index){
    NoteStruct out;
    out.letter = letter;
    out.index = index;
    return out;
}

NS_INLINE NoteLetter ScaleNextNote(NoteLetter note){
    switch (note) {
        case Note_A: return Note_B;
        case Note_B: return Note_C;
        case Note_C: return Note_D;
        case Note_D: return Note_E;
        case Note_E: return Note_F;
        case Note_F: return Note_G;
        case Note_G: return Note_A;
        default:
            break;
    }
}

NS_INLINE NoteLetter ScalePreviousNote(NoteLetter note){
    switch (note) {
        case Note_A: return Note_G;
        case Note_B: return Note_A;
        case Note_C: return Note_B;
        case Note_D: return Note_C;
        case Note_E: return Note_D;
        case Note_F: return Note_E;
        case Note_G: return Note_F;
        default:
            break;
    }
}

NS_INLINE NoteStruct ScaleNextNoteStruct(NoteStruct note){
    NoteStruct out;
    out.letter = ScaleNextNote(note.letter);
    if (out.letter==Note_A) {
        out.index = note.index+1;
    }else out.index = note.index;
    return out;
}

NS_INLINE NoteStruct ScalePrevioustNoteStruct(NoteStruct note){
    NoteStruct out;
    out.letter = ScalePreviousNote(note.letter);
    if (out.letter==Note_G) {
        out.index = note.index-1;
    }else out.index = note.index;
    return out;
}


NS_INLINE NSComparisonResult CompareNotes(NoteStruct note1, NoteStruct note2){
    if (note1.index<note2.index) {
        return NSOrderedAscending;
    }else if (note1.index>note2.index){
        return NSOrderedDescending;
    }else{
        if (note1.letter==note2.letter) return NSOrderedSame;
        else if (note1.letter<note2.letter) return NSOrderedAscending;
        else return NSOrderedDescending;
    }
}

NS_INLINE NSString* StringFromNote(NoteStruct note){
    NSString* letterString;
    switch (note.letter) {
        case Note_C:
            letterString = @"C";
            break;
        case Note_D:
            letterString = @"D";
            break;
        case Note_E:
            letterString = @"E";
            break;
        case Note_F:
            letterString = @"F";
            break;
        case Note_G:
            letterString = @"G";
            break;
        case Note_A:
            letterString = @"A";
            break;
        case Note_B:
            letterString = @"B";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@%d", letterString, note.index];
}

NS_INLINE TimeSignature MakeTimeSignature(NSInteger num, NSInteger denom){
    TimeSignature out;
    out.numerator = num;
    out.denominator = denom;
    return out;
};

typedef struct _StaveInsets {
    CGFloat top;
    CGFloat bottom;
    CGFloat left;
    CGFloat right;
} StaveInsets;

NS_INLINE StaveInsets MakeStaveInsets(CGFloat top, CGFloat bottom, CGFloat left, CGFloat right){
    StaveInsets out;
    out.top= top;
    out.bottom = bottom;
    out.left = left;
    out.right = right;
    return out;
}

typedef struct _ViewInsets{
    CGFloat left;
    CGFloat right;
    CGFloat top;
    CGFloat bottom;
} ViewInsets;

NS_INLINE ViewInsets MakeViewInsets(CGFloat left, CGFloat right, CGFloat top, CGFloat bottom){
    ViewInsets out;
    out.left = left;
    out.right = right;
    out.top = top;
    out.bottom = bottom;
    return out;
}



#endif /* StaveConstants_h */
