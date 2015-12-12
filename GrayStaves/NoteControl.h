//
//  NoteControl.h
//  GrayStaves
//
//  Created by Thomas Gray on 29/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteComponent.h"
#import "NoteTailComponent.h"
#import "AccidentalComponent.h"
#import "BasicStaveView.h"
#import "StaveComponentControl.h"
#import "NoteHeadComponent.h"

@class NoteTailComponent;

@interface NoteControl : StaveComponentControl{
    CGFloat _tailLength;
}

@property NoteHeadComponent* noteComponent;
@property NoteTailComponent* noteTailComponent;
@property AccidentalComponent* accidental;

@property (nonatomic) NoteStruct noteStruct;
@property (nonatomic) NoteModifier modifier;
@property (nonatomic) NoteTimeValue timeValue;

@property (nonatomic) BOOL dotted;
@property (nonatomic) BOOL tailUp;
@property (nonatomic) BOOL drawFlag;

-(instancetype)initWithScale:(CGFloat)scle note:(NoteStruct)nte timeValue:(NoteTimeValue)tval andModifier:(NoteModifier)mod;
@end
