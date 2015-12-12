//
//  GrayStavesDelegate.m
//  GrayStaves
//
//  Created by Thomas Gray on 24/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "GrayStavesDelegate.h"

@implementation GrayStavesDelegate

+(NSImage *)getImageNamed:(NSString *)name{
    NSString* imagespath = [[[NSBundle bundleForClass:[GrayStavesDelegate class]]resourcePath]stringByAppendingString:@"/Images/"];
    NSString* imagePath = [NSString stringWithFormat:@"%@%@.png", imagespath, name];
    NSImage* out = [[NSImage alloc]initWithContentsOfFile:imagePath];
    return out;
}

+(CGFloat)heightForNote:(NoteStruct)note givenRelativeNote:(NoteStruct)relNote atHeight:(CGFloat)relHeight andScale:(CGFloat)scale{
begin:;
    NSComparisonResult comparison = CompareNotes(relNote, note);
    if (comparison==NSOrderedAscending) {
        relNote=ScaleNextNoteStruct(relNote);
        relHeight +=(scale/2.);
        goto begin;
    }else if (comparison==NSOrderedDescending){
        relNote = ScalePrevioustNoteStruct(relNote);
        relHeight -= (scale/2.);
        goto begin;
    }else{
        return relHeight;
    }
}

+(NoteStruct)baseNoteForStaveClef:(ClefEnum)clef{
    switch (clef) {
        case ClefAlto:
            return MakeNoteStruct(Note_G, -1);
        case ClefBass:
            return MakeNoteStruct(Note_A, -1);
        case ClefTenor:
            return MakeNoteStruct(Note_E, -1);
        case ClefTreble:
            return MakeNoteStruct(Note_F, 0);
        default:
            break;
    }
}

+(NoteStruct)noteForHeight:(CGFloat)height givenRelativeNote:(NoteStruct)relNote atHeight:(CGFloat)relHeight andScale:(CGFloat)scale{
    NoteStruct out = relNote;
    CGFloat relBottom = relHeight + scale/4.;
here:;
    if (height>=relBottom && height<relBottom+scale/2.) {
        return out;
    }else if (height>relBottom){
        out = ScaleNextNoteStruct(out);
        relBottom+=scale/2.;
    }else{
        out = ScalePrevioustNoteStruct(out);
        relBottom -= scale/2.;
    }
    goto here;
}

@end
