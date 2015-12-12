//
//  GrayStavesDelegate.h
//  GrayStaves
//
//  Created by Thomas Gray on 24/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StaveConstants.h"

@interface GrayStavesDelegate : NSObject

+(NSImage*)getImageNamed:(NSString*)name;

+(CGFloat)heightForNote:(NoteStruct)note givenRelativeNote:(NoteStruct)relNote atHeight:(CGFloat)relHeight andScale:(CGFloat)scale;
+(NoteStruct)baseNoteForStaveClef:(ClefEnum)clef;
+(NoteStruct)noteForHeight:(CGFloat)height givenRelativeNote:(NoteStruct)relNote atHeight:(CGFloat)relHeight andScale:(CGFloat)scale;

@end
