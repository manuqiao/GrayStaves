//
//  NoteConnection.h
//  GrayStaves
//
//  Created by Thomas Gray on 08/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"
#import "NoteComponent.h"
@class NoteComponent;

@interface NoteConnection : BasicStaveComponent{
    CGFloat _leftDeviation;
    CGFloat _rightDeviation;
}

@property (nonatomic) NoteTimeValue timeValue;
@property (nonatomic) NSMutableArray<NoteComponent*>* notes;

@property (nonatomic) CGFloat yRightmostValue;
@property (nonatomic) CGFloat xRightmostValue;

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval;

-(void)addNotes:(NoteComponent*)note1, ... NS_REQUIRES_NIL_TERMINATION;
-(void)removeNotes:(NoteComponent *)note, ... NS_REQUIRES_NIL_TERMINATION;

-(void)align;

@end
