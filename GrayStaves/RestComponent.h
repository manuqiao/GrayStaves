//
//  RestComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 02/12/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"

@interface RestComponent : BasicStaveComponent

@property (nonatomic) NoteTimeValue timeValue;

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval;

@end
