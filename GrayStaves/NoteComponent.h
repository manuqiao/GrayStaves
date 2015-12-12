//
//  NoteComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 26/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicNoteComponent.h"
#import "NoteTailComponent.h"
#import "NoteHeadComponent.h"
#import "AccidentalComponent.h"
#import "NoteStaveLineComponent.h"

@class NoteStaveLineComponent;
@class NoteTailComponent;

@interface NoteComponent : BasicNoteComponent

@property NoteHeadComponent* noteComponent;
@property NoteTailComponent* noteTailComponent;
@property AccidentalComponent* accidental;
@property NoteStaveLineComponent* staveLine;

@property (nonatomic) NoteStruct noteStruct;
@property (nonatomic) NoteModifier modifier;
@property (nonatomic) NoteTimeValue timeValue;

@property (nonatomic) BOOL dotted;
//@property (nonatomic) BOOL tailUp;
//@property (nonatomic) BOOL drawFlag;
@property (nonatomic) BOOL modifierRight;
//@property (nonatomic) BOOL drawTail;

-(instancetype)initWithScale:(CGFloat)scle note:(NoteStruct)nte timeValue:(NoteTimeValue)tval andModifier:(NoteModifier)mod;

-(void)setBackingLinesVisible:(BOOL)vis withLineNumber:(int)number drawingUpwards:(BOOL)drawup onNote:(BOOL)on;

-(NSPoint)tailTipPoint:(BOOL)front;

@end
