//
//  NoteHeadComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 03/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"

@interface NoteHeadComponent : BasicStaveComponent

@property (nonatomic) NoteStruct note;
@property (nonatomic) NoteTimeValue timeValue;

-(instancetype)initWithScale:(CGFloat)scale note:(NoteStruct)note andTimeValue:(NoteTimeValue)timeValue;

+(instancetype)note:(NoteStruct)nte withTimeValue:(NoteTimeValue)tmeval andScale:(CGFloat)scle;

+(CGFloat)widthRatio;

@end
