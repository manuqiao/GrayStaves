//
//  NoteGroupComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 09/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicNoteComponent.h"
#import "NoteComponent.h"

@interface NoteGroupComponent : BasicNoteComponent

@property NSMutableArray<NoteComponent*>* notes;
@property NoteTailComponent* mainTail;
@property NoteTailComponent* connectingTail;

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval tailUp:(BOOL)up;

-(void)addNotes:(NoteComponent*)note1, ... NS_REQUIRES_NIL_TERMINATION;
-(void)removeNotes:(NoteComponent *)note, ... NS_REQUIRES_NIL_TERMINATION;

-(void)addNote:(NoteStruct)note withModifier:(NoteModifier)mod;

@end
