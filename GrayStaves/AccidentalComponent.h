//
//  AccidentalComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 29/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"

@interface AccidentalComponent : BasicStaveComponent

@property (nonatomic) NoteModifier modifier;
@property (nonatomic) NoteStruct note;

-(instancetype)initWithScale:(CGFloat)scale andModifier:(NoteModifier)mod;

@end
