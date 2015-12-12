//
//  NoteTailComponent.h
//  GrayStaves
//
//  Created by Thomas Gray on 29/11/2015.
//  Copyright © 2015 Thomas Gray. All rights reserved.
//

#import "BasicStaveComponent.h"
#import "NoteComponent.h"
#import "NoteTailFlagComponent.h"

@class NoteComponent;

@interface NoteTailComponent : BasicStaveComponent

@property (nonatomic) NoteTailFlagComponent* flagComponent;
@property (nonatomic) NoteTimeValue timeValue;
@property (nonatomic) BOOL tailUp;
@property (nonatomic) CGFloat tailLengthScale;
@property (nonatomic) BOOL drawFlags;
@property (nonatomic) BOOL autoSize;

-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval;
-(instancetype)initWithScale:(CGFloat)scale andTimeValue:(NoteTimeValue)tval tailUp:(BOOL)up;

-(CGFloat)stemWidth;
-(void)setTailExtent:(CGFloat)bottomHeight to:(CGFloat)topHeight;

@end
